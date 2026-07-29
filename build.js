const { readFileSync, writeFileSync } = require('node:fs');
const { join } = require('node:path');

const projectDirectory = __dirname;
const sourceFile = join(projectDirectory, 'README.md');
const targetFile = join(projectDirectory, 'index.html');

const pageTitle = 'Eugene Panov — CV';
const pageDescription =
  'Eugene Panov — Senior Full Stack Developer. PHP/Laravel and React, ' +
  'automation and microservices, 10+ years in payments and fintech. Limassol, Cyprus.';
const canonicalUrl = 'https://www.panov.id/';
const telegramAccount = '@ppaannoovv';
const telegramUrl = 'https://t.me/ppaannoovv';

function escapeHtml(text) {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

function removeMarkdownMarkers(text) {
  return text.replace(/\*\*/g, '').replace(/`/g, '');
}

function renderExternalLink(url, label) {
  return `<a href="${url}" target="_blank" rel="noreferrer">${label}</a>`;
}

function linkifyUrls(text) {
  return text.replace(/https?:\/\/\S+/g, url => renderExternalLink(url, url));
}

function linkifyTelegram(text) {
  return text.replace(telegramAccount, renderExternalLink(telegramUrl, telegramAccount));
}

// Applied before the stylesheet paints, so a stored light theme never flashes black.
const themeBootstrapScript = `
      (function () {
        var storedTheme = null;
        try {
          storedTheme = window.localStorage.getItem('theme');
        } catch (storageError) {
          storedTheme = null;
        }
        document.documentElement.setAttribute(
          'data-theme',
          storedTheme === 'light' ? 'light' : 'dark'
        );
      })();`;

const themeSwitchScript = `
      (function () {
        var buttons = document.querySelectorAll('[data-theme-value]');

        function applyTheme(theme) {
          document.documentElement.setAttribute('data-theme', theme);
          buttons.forEach(function (button) {
            button.setAttribute(
              'aria-pressed',
              String(button.dataset.themeValue === theme)
            );
          });
          try {
            window.localStorage.setItem('theme', theme);
          } catch (storageError) {
            /* private mode — the choice simply is not remembered */
          }
        }

        buttons.forEach(function (button) {
          button.addEventListener('click', function () {
            applyTheme(button.dataset.themeValue);
          });
        });

        applyTheme(document.documentElement.getAttribute('data-theme'));
      })();`;

function renderThemeSwitch() {
  return `    <nav class="theme-switch" aria-label="Colour theme">
      <button
        type="button"
        class="pill pill-red"
        data-theme-value="dark"
        aria-pressed="true"
        aria-label="Dark theme"
        title="Dark theme"
      >
        <span class="pill-capsule" aria-hidden="true"></span>
      </button>
      <button
        type="button"
        class="pill pill-blue"
        data-theme-value="light"
        aria-pressed="false"
        aria-label="Light theme"
        title="Light theme"
      >
        <span class="pill-capsule" aria-hidden="true"></span>
      </button>
    </nav>`;
}

function renderPage(body) {
  return `<!DOCTYPE html>
<html lang="en" data-theme="dark">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${pageTitle}</title>
    <meta name="description" content="${pageDescription}" />
    <link rel="canonical" href="${canonicalUrl}" />
    <meta property="og:type" content="profile" />
    <meta property="og:title" content="${pageTitle}" />
    <meta property="og:description" content="${pageDescription}" />
    <meta property="og:url" content="${canonicalUrl}" />
    <meta name="twitter:card" content="summary" />
    <script>${themeBootstrapScript}
    </script>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
${renderThemeSwitch()}
    <pre>
${body}
    </pre>
    <script>${themeSwitchScript}
    </script>
  </body>
</html>
`;
}

const markdownSource = readFileSync(sourceFile, 'utf8');
const renderedBody = linkifyTelegram(
  linkifyUrls(removeMarkdownMarkers(escapeHtml(markdownSource.trimEnd())))
);

writeFileSync(targetFile, renderPage(renderedBody), 'utf8');

console.log(`Generated ${targetFile} from ${sourceFile}`);
