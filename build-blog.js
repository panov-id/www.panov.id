const { readFileSync, writeFileSync, readdirSync, mkdirSync, existsSync } = require('node:fs');
const { join } = require('node:path');

const projectDirectory = __dirname;
const postsDirectory = join(projectDirectory, 'content', 'posts');
const blogDirectory = join(projectDirectory, 'blog');
const coversDirectory = join(blogDirectory, 'covers');

// Без «www.» — с 27.08.2026 префиксный адрес отвечает 301 на этот. Отсюда растут
// canonical страниц, og:url, ссылки и guid в ленте: guid важнее прочего, потому
// что читалки считают запись новой, когда он меняется, и один переезд адреса они
// переживут, а два — уже дубли в чужих лентах.
const siteUrl = 'https://panov.id';
const blogTitle = 'Панов — записки';
const blogDescription =
  'Заметки о разработке: спецификации, ревью, ошибки и то, что из них выносится.';

function escapeHtml(text) {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

// A stable 32-bit hash, so a title always yields the same cover.
function hashText(text) {
  let hash = 0x811c9dc5;
  for (let index = 0; index < text.length; index += 1) {
    hash ^= text.charCodeAt(index);
    hash = Math.imul(hash, 0x01000193) >>> 0;
  }
  return hash;
}

function createRandomSequence(seed) {
  let state = seed >>> 0;
  return function next() {
    state = (Math.imul(state, 1664525) + 1013904223) >>> 0;
    return state / 0x100000000;
  };
}

function renderCover(title) {
  const random = createRandomSequence(hashText(title));
  const hue = Math.floor(random() * 360);
  const lineCount = 14 + Math.floor(random() * 10);
  const lines = [];

  for (let index = 0; index < lineCount; index += 1) {
    const y = 40 + Math.floor(random() * 550);
    const width = 120 + Math.floor(random() * 900);
    const x = Math.floor(random() * (1180 - width));
    const thickness = 2 + Math.floor(random() * 10);
    const opacity = (0.15 + random() * 0.6).toFixed(2);
    const shift = (hue + index * 7) % 360;
    lines.push(
      `  <rect x="${x}" y="${y}" width="${width}" height="${thickness}" ` +
        `fill="hsl(${shift} 70% 60%)" opacity="${opacity}" />`
    );
  }

  const radius = 60 + Math.floor(random() * 90);
  lines.push(
    `  <circle cx="${1200 - radius - 60}" cy="${radius + 60}" r="${radius}" ` +
      `fill="none" stroke="hsl(${hue} 80% 65%)" stroke-width="3" opacity="0.7" />`
  );

  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 630" width="1200" height="630" role="img" aria-label="Обложка записи">
  <rect width="1200" height="630" fill="#0b0b0d" />
${lines.join('\n')}
</svg>
`;
}

function renderInline(text) {
  return escapeHtml(text)
    .replace(/`([^`]+)`/g, '<code>$1</code>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    .replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2">$1</a>');
}

function renderMarkdown(markdown) {
  const lines = markdown.split('\n');
  const html = [];
  let index = 0;

  while (index < lines.length) {
    const line = lines[index];

    if (line.startsWith('```')) {
      const code = [];
      index += 1;
      while (index < lines.length && !lines[index].startsWith('```')) {
        code.push(escapeHtml(lines[index]));
        index += 1;
      }
      index += 1;
      html.push(`<pre class="code"><code>${code.join('\n')}</code></pre>`);
      continue;
    }

    if (line.startsWith('|')) {
      const rows = [];
      while (index < lines.length && lines[index].startsWith('|')) {
        rows.push(lines[index]);
        index += 1;
      }
      const cells = row =>
        row.split('|').slice(1, -1).map(cell => cell.trim());
      const header = cells(rows[0]);
      const body = rows.slice(2).map(cells);
      html.push(
        '<table><thead><tr>' +
          header.map(cell => `<th>${renderInline(cell)}</th>`).join('') +
          '</tr></thead><tbody>' +
          body
            .map(row => '<tr>' + row.map(cell => `<td>${renderInline(cell)}</td>`).join('') + '</tr>')
            .join('') +
          '</tbody></table>'
      );
      continue;
    }

    if (/^#{2,4} /.test(line)) {
      const level = line.match(/^#+/)[0].length;
      html.push(`<h${level}>${renderInline(line.replace(/^#+ /, ''))}</h${level}>`);
      index += 1;
      continue;
    }

    if (line.startsWith('> ')) {
      const quote = [];
      while (index < lines.length && lines[index].startsWith('> ')) {
        quote.push(lines[index].slice(2));
        index += 1;
      }
      html.push(`<blockquote><p>${renderInline(quote.join(' '))}</p></blockquote>`);
      continue;
    }

    if (/^[-*] /.test(line) || /^\d+\. /.test(line)) {
      const ordered = /^\d+\. /.test(line);
      const items = [];
      while (index < lines.length && /^([-*] |\d+\. )/.test(lines[index])) {
        items.push(lines[index].replace(/^([-*] |\d+\. )/, ''));
        index += 1;
      }
      const tag = ordered ? 'ol' : 'ul';
      html.push(`<${tag}>${items.map(item => `<li>${renderInline(item)}</li>`).join('')}</${tag}>`);
      continue;
    }

    if (line.trim() === '---') {
      html.push('<hr />');
      index += 1;
      continue;
    }

    if (line.trim() === '') {
      index += 1;
      continue;
    }

    const paragraph = [];
    while (
      index < lines.length &&
      lines[index].trim() !== '' &&
      !lines[index].startsWith('#') &&
      !lines[index].startsWith('|') &&
      !lines[index].startsWith('```') &&
      !lines[index].startsWith('> ') &&
      !/^([-*] |\d+\. )/.test(lines[index])
    ) {
      paragraph.push(lines[index]);
      index += 1;
    }
    html.push(`<p>${renderInline(paragraph.join(' '))}</p>`);
  }

  return html.join('\n');
}

function parsePost(fileName) {
  const raw = readFileSync(join(postsDirectory, fileName), 'utf8');
  const match = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!match) {
    throw new Error(`Post ${fileName} has no front matter`);
  }
  const meta = {};
  for (const line of match[1].split('\n')) {
    const separator = line.indexOf(':');
    if (separator === -1) continue;
    meta[line.slice(0, separator).trim()] = line
      .slice(separator + 1)
      .trim()
      .replace(/^"|"$/g, '');
  }
  return {
    slug: fileName.replace(/^\d{4}-\d{2}-\d{2}-/, '').replace(/\.md$/, ''),
    fileName,
    title: meta.title,
    date: meta.date,
    summary: meta.summary,
    body: match[2],
  };
}

const themeBootstrapScript = `
      (function () {
        try {
          var stored = localStorage.getItem('theme');
          if (stored === 'light' || stored === 'dark') {
            document.documentElement.setAttribute('data-theme', stored);
          }
        } catch (error) {}
      })();`;

function renderPage({ title, description, canonical, cover, body }) {
  return `<!doctype html>
<html lang="ru">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${escapeHtml(title)}</title>
    <meta name="description" content="${escapeHtml(description)}" />
    <link rel="canonical" href="${canonical}" />
    <link rel="alternate" type="application/rss+xml" title="${escapeHtml(blogTitle)}" href="${siteUrl}/feed.xml" />
    <meta property="og:type" content="article" />
    <meta property="og:title" content="${escapeHtml(title)}" />
    <meta property="og:description" content="${escapeHtml(description)}" />
    <meta property="og:url" content="${canonical}" />
${cover ? `    <meta property="og:image" content="${cover}" />\n` : ''}    <script>${themeBootstrapScript}
    </script>
    <link rel="stylesheet" href="/styles.css" />
  </head>
  <body>
    <main class="article">
${body}
    </main>
  </body>
</html>
`;
}

function formatDate(value) {
  const months = [
    'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
    'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря',
  ];
  const [year, month, day] = value.split('-').map(Number);
  return `${day} ${months[month - 1]} ${year}`;
}

function toRfc822(value) {
  return new Date(`${value}T09:00:00Z`).toUTCString();
}

mkdirSync(coversDirectory, { recursive: true });

const posts = existsSync(postsDirectory)
  ? readdirSync(postsDirectory)
      .filter(name => name.endsWith('.md'))
      .map(parsePost)
      .sort((first, second) => second.fileName.localeCompare(first.fileName))
  : [];

for (const post of posts) {
  writeFileSync(join(coversDirectory, `${post.slug}.svg`), renderCover(post.title), 'utf8');

  const body = [
    '      <p class="back"><a href="/blog/">← все записи</a></p>',
    `      <h1>${escapeHtml(post.title)}</h1>`,
    `      <p class="meta">${formatDate(post.date)}</p>`,
    `      <img class="cover" src="/blog/covers/${post.slug}.svg" alt="" />`,
    renderMarkdown(post.body).split('\n').map(line => `      ${line}`).join('\n'),
    '      <p class="back"><a href="/">← визитка</a> · <a href="/feed.xml">RSS</a></p>',
  ].join('\n');

  writeFileSync(
    join(blogDirectory, `${post.slug}.html`),
    renderPage({
      title: post.title,
      description: post.summary,
      canonical: `${siteUrl}/blog/${post.slug}.html`,
      cover: `${siteUrl}/blog/covers/${post.slug}.svg`,
      body,
    }),
    'utf8'
  );
}

const listBody = [
  `      <h1>${escapeHtml(blogTitle)}</h1>`,
  `      <p class="meta">${escapeHtml(blogDescription)}</p>`,
  '      <ul class="posts">',
  ...posts.map(
    post =>
      `        <li><a href="/blog/${post.slug}.html">${escapeHtml(post.title)}</a>` +
      `<span class="meta"> · ${formatDate(post.date)}</span><br />${escapeHtml(post.summary)}</li>`
  ),
  '      </ul>',
  '      <p class="back"><a href="/">← визитка</a> · <a href="/feed.xml">RSS</a></p>',
].join('\n');

writeFileSync(
  join(blogDirectory, 'index.html'),
  renderPage({
    title: blogTitle,
    description: blogDescription,
    canonical: `${siteUrl}/blog/`,
    cover: null,
    body: listBody,
  }),
  'utf8'
);

const feedItems = posts
  .map(
    post => `    <item>
      <title>${escapeHtml(post.title)}</title>
      <link>${siteUrl}/blog/${post.slug}.html</link>
      <guid isPermaLink="true">${siteUrl}/blog/${post.slug}.html</guid>
      <pubDate>${toRfc822(post.date)}</pubDate>
      <description>${escapeHtml(post.summary)}</description>
    </item>`
  )
  .join('\n');

writeFileSync(
  join(projectDirectory, 'feed.xml'),
  `<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
  <channel>
    <title>${escapeHtml(blogTitle)}</title>
    <link>${siteUrl}/blog/</link>
    <description>${escapeHtml(blogDescription)}</description>
    <language>ru</language>
${feedItems}
  </channel>
</rss>
`,
  'utf8'
);

console.log(`Generated ${posts.length} post(s), blog index and feed.xml`);
