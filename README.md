## Eugene Panov – Senior Full Stack Developer | Automation & Microservices Specialist | PHP

**Location**: Limassol, Cyprus (CY)  
**LinkedIn**: `https://www.linkedin.com/in/evgenii-panov`  
**GitHub**: `https://github.com/evpanov`  
**GitHub**: `https://github.com/panov-id`  
**Telegram**: `@ppaannoovv`  
**Blog**: `https://panov.id/blog/`  
**Languages**: Russian (Native), English (B1)

---

## Summary

Senior Full Stack Engineer with **10+ years** of experience building scalable web applications and modernizing legacy systems, mainly in **payments and fintech**. Strong expertise in **PHP/Laravel** backends and **React** frontends, with a focus on clean architecture, reliability, and performance. Experience designing and implementing microservices, high‑load APIs, dashboards, and internal tools for fintech, e‑commerce, and analytics. Actively uses AI to speed up delivery, refactoring, and documentation while keeping control over architecture and code quality.

Looking for new opportunities as **Full Stack Engineer**, **PHP Backend Developer**, **ReactJS Frontend Developer** (remote or Cyprus-based).

---

## Core Skills

- **Backend**: PHP 7/8, Laravel, Lumen, PHPUnit, MySQL, PostgreSQL, Redis, RESTful APIs
- **Frontend**: JavaScript (ES6+), React, HTML5, CSS3
- **Architecture**: Microservices, system design, database design
- **DevOps & Tools**: Docker, Git, CI/CD, Kafka, Vault, KeyCloak
- **Domains**: Payments, fintech, CRM, dashboards, data processing

---

## Experience

### Agent Manager – NEIGHBRO.PLACE & SOSED.PLACE  
**Jul 2026 – Present** • Limassol, Cyprus • Remote • Self-employed

---

### Engineer – NDA  
**Mar 2026 – Present** • Full-time

---

### Senior Full Stack Developer – Bizcombo Technologies Ltd  
**Dec 2025 – Mar 2026** • Limassol, Cyprus • On-site

- Design and implement automation workflows connecting external/internal APIs.  
- Build custom modules and architect scalable microservices for high‑performance backend systems.  
- Focus on maintainable code, observability, and reliability of the automation platform.

---

### Full Stack Developer – F&F WORLDWIDE SERVICES LTD  
**Mar 2023 – Jul 2025** • Limassol, Cyprus • On-site

- Developed, refactored, and supported an in‑house DIY CRM & Client Area for a fintech company.  
- Implemented and maintained payment gateway integrations with providers (B2BInPay, VirtualPay, Skrill, Neteller, etc.).  
- Built and supported trader gateways and integrations for MT4/MT5.  
- Performed data analysis, investigated and resolved production issues, and handled operational tasks.  
- **Stack**: PHP 7/8, Laravel, Lumen, MySQL, Redis, Kafka, Vault, KeyCloak, PHPUnit, Docker.

---

### Full Stack Web Developer – Reyo Media Cyprus  
**Apr 2022 – Feb 2023** • Limassol, Cyprus • Remote

- Developed, refactored, and supported parts of a DIY analytics dashboard.  
- Implemented procedures and services to retrieve large reports from affiliate platforms via APIs and web scraping.  
- Monitored and resolved errors using Sentry, created and tracked issues in Asana.  
- Set up Dockerized environments for local development.  
- **Stack**: PHP 7.2+, Laravel, PostgreSQL, Redis, PHPUnit, Docker, Asana, OneSignal, AWS.

---

### Full Stack Developer – Unlimit  
**Dec 2014 – Feb 2022** • Limassol, Cyprus • On-site

- Developed, integrated, and supported a DIY e‑commerce platform (AddStore.com), including payment integrations (PayPal, OnlinePay), text search powered by Elastic, and YML import (Yandex Market).  
- Built dashboards for MetaTrader and tools for merchants, including a Merchant Interview Questions application.  
- Developed and supported RESTful APIs for partners and business products such as “Card Issuing”, and a relationship manager for SmartVista.  
- Worked with high‑load financial systems and complex integrations in the payment industry.  
- **Stack**: Yii2, PHP 7.4+, Laravel, ReactJS, MySQL, Oracle, Elastic, SOAP, JavaScript, jQuery, HTML, CSS, Twig.

---

### Web‑Developer – Dengi Online  
**Apr 2011 – Dec 2014** • Saint Petersburg, Russia • On-site

- Integrated payment systems (mobile commerce, card payments, wallet and terminal systems) into the aggregation platform “Dengi Online”.  
- Developed and supported integration modules to ensure stable operation.  
- Assisted clients integrating with the aggregation system and supported logistics services aggregators.  
- **Stack**: Linux, Apache, MySQL, PHP, HTML, CSS, JavaScript, jQuery, XML, SOAP, PGP, OpenSSL.

---

### Earlier Roles

- **Web‑Developer – Metrika (Wholesale Trade/Import-Export)** (Aug 2010 – Apr 2011)  
  Developed and supported internal web interfaces (frontend and backend) for product catalogues, Axapta‑based information systems, and payment order preparation tools.  
  **Stack**: Linux, Apache, MySQL, MSSQL, PHP, HTML, CSS, JavaScript, jQuery, AJAX, ExtJS.

- **Web Developer – KIT Finance Investment Bank** (May 2007 – Apr 2010)  
  Developed and supported intranet portals and internet websites, including modules for document exchange and internal tools.  
  **Stack**: Linux, Apache, MySQL, PHP4/PHP5, HTML, CSS, JavaScript, Prototype JS, ExtJS, AJAX.

- **ASP Web Programmer – Piter Plus OOO (Internet Services)** (Feb 2006 – May 2007)  
  Developed and supported online shop modules and billboard systems.  
  **Stack**: IIS, ASP, MSSQL, HTML, CSS, JavaScript, Photoshop.

- **Webmaster – Efo OOO (Electronics, Components, and Semiconductor Manufacturing)** (Jan 2005 – Jan 2006)  
  Maintained content (news, articles), processed images, and supported company web presence.  
  **Stack**: HTML, CSS, Photoshop.

---

## Education

**Peter the Great St. Petersburg Polytechnic University** – Technics  
2000 – 2006 • Russia

---

## Selected Projects

- **SOSED.PLACE** – `https://sosed.place`  
  A local neighbour network: say a word to people nearby, match, talk — and let go. No profiles, no feeds.

- **NEIGHBRO** – `https://neighbro.place`  
  Good neighbours. Real moments.

- **Waste Collection in Cyprus** – `https://wastecollectioncyprus.com`  
  Service for managing and optimizing waste collection information in Cyprus.

- **Psytican** – `https://psytican.com`  
  Web application in the mental health / psychology domain.

- **Paparad** – `https://paparad.bandcamp.com`  
  Personal creative project (music).

---

## AI Assistant Setup

How I work with an AI coding assistant (Claude Code), with a second CLI assistant (Codex) beside it for well-specified mechanical work: the rules, the hooks that enforce them, the skills, the cheap executors and a local voice. This section describes the setup; the files themselves live in `~/.claude`.

### Layout

```
~/.claude/
  CLAUDE.md          core rules, loaded into every session (33 numbered rules)
  settings.json      permissions, model, hook wiring
  hooks/             23 hooks that enforce the rules mechanically, each with a case file
  scripts/           session clock, blog counter, digest, token report, codex wrapper
  skills/            11 skills: session-start, git-workflow, review-panel, docs-pairing,
                     foreign-repos, workbench, blog-post, voice, delegate, artel, synced
  agents/            haiku-runner, sonnet-runner (cheap executors), verifier (read-only checker)
  templates/         the rules block that is stitched into every project's instructions
  tts/               local voice: speech synthesis in a container, playback queue, on/off
  stats/             local statistics: hook blocks and sessions, charts
```

### Rules

A summary. The rules themselves are in `CLAUDE.md`, in Russian.

**How we work**
- Decided things are not asked again; the next item of an approved plan is taken at once. I am asked only for the heavy or irreversible: money, accounts, credentials, anything outside the project, destructive actions, product forks.
- A fork inside an approved plan that touches more than one file, a public interface or data is settled by a quorum of two or three cheap agents against the documents; a tie goes to what was approved. Every decision is written down with the rejected options.
- Do everything a script, CLI or API can do; leave me only accounts, payments, credentials and UI toggles.
- Before a task: a numbered checklist, ticked off as it closes; an item closes only on a machine check.
- No ad-hoc commands: state-changing shell goes through a script, debugged by editing it. Every command carries a plain description of what it does and what we expect.
- An answer to my question is an answer, not a command. "Yes" or a picked option closes the question; it does not start the edit.
- Several sessions on one repository work as a crew with a shared board and mutual watch (`artel`).

**How it answers**
- Answers in Russian; code, comments and commit messages in English, no filler.
- Discussing a change means showing the code: snippet, before/after, exact `file:line`.
- Choices go through an interactive question form, never prose. Every option names the place, the consequence and the price. No yes/no questions, and no questions after the work is done.
- A finished piece ends with what to take next, as a form, ordered by what fires first.
- The first line is the conclusion; a 3–5 line diff-style summary opens the answer. Anything with a level of importance gets a colour marker: 🔴 critical, 🟠 caveat, 🟡 defect, 🟢 done and machine-checked, 🟣 fact, ⚪ deferred.
- Anything an agent said is attributed and marked verified (with how) or not verified. A finding that failed verification is not repeated at all.
- Code outside the session's repo is named by repo or package, never "the SDK" or "the library".
- Date, session age, branch and uncommitted files are drawn by a status-line mod, not written into the answer.

**What we don't do**
- No commits or pushes without an explicit word, and no asking whether it's time. The one exception is this blog.
- No invented API fields or behaviour. If something was added that the API lacks, it is said plainly.
- Nothing is installed on the host — only inside containers.
- No merge request suggestions. Work projects' CI/CD is not ours to write, edit or propose. No deploy talk before the product walks its own main path.

**Checking itself**
- Numbers are recounted by a script, not remembered.
- Claims about a database, framework or library are checked by an experiment in a container.
- A large piece goes through a panel of independent reviewer agents before it is called done; the security lens is mandatory.
- "Done" only after execution, and execution after the last edit; a large piece is handed to the `verifier` agent.
- "Does not touch the network" is proven by a run in a container without a network, not by a comment. A 401/403/429 from a foreign API stops everything at once.
- Documents come in pairs, Russian and English.

**Token economy** (added 08.10.2026)
- Noisy output — test runs, static analysis, container logs, diffs, HTTP journals — is never read raw. It goes through `digest <kind>`: at most 12 lines, the full text saved to a session file, the path named. A hook refuses a noisy command without it.
- A big file is read in part or not at all: a hook refuses an image over 200 KB, a PDF without a page range, a text file over 64 KB without a window. The measurement behind it: over a week, 70 % of all tool-result bytes were reads of the session's own PDF reports and screenshots; test runs were not in the top twelve.
- Work is routed by kind, and a hook enforces the routing: mechanical steps with a machine check go to `haiku-runner`, module-sized work to a spec to `sonnet-runner`, a ready diff plan or template generation to the second assistant through `codex-run` (same task template: goal, files, steps, forbidden, check; sandbox without network; back comes a diffstat, a flag on any file outside the list, and the digest of the check). The main model keeps decisions, security and review.
- `token-report --days N` reads the session transcripts and shows where the bytes went: per day, per tool, top sources. A saving is claimed only with its number.

**Time**
- Date and time come from a script, not from memory.
- A new session starts by reporting where we are, not by editing.
- Older than 6 hours: re-read rules, skills, hooks and memory from disk before acting.
- Older than 8 hours: save a handoff and stop until restart.

**Voice**
- With the voice flag on, everything in Russian is spoken: command descriptions and question forms by a hook, the rest by the assistant itself. Code, commands, paths and the status line are not spoken. Picking an option or pressing Enter silences it at once.

### Hooks

- `session-start.sh`, `blog-due.sh`, `sync-project-rules.py` (SessionStart) — where we are and what changed since the last start; a reminder when a blog post is due; the global rules block stitched into the project's instructions when the template is newer.
- `voice-hush.py` (UserPromptSubmit) — Enter silences the voice.
- `session-stop.py` (PreToolUse, any) — after 8 hours the session saves a handoff and stops.
- `guard-push.sh`, `guard-commit.sh` (PreToolUse, Bash) — a push names its target and a shared branch needs my approval; document pairs and fresh lock files before a commit.
- `guard-long-output.py` (PreToolUse, Bash) — a test run, logs or a full diff must go through `digest`, `tail` or a file.
- `guard-read-size.py` (PreToolUse, Read) — big pictures, PDFs without pages and big files without a window are refused.
- `guard-agent-model.py` (PreToolUse, Agent) — a subagent names its model or its runner; the expensive default is never inherited silently.
- `guard-question.py` (PreToolUse, question) — rejects options that don't say what they cost.
- `speak.py`, `speak-stop.sh` — speaks command descriptions and question forms; an answer picked, the voice stops.
- `artel-hold.py`, `artel-turn.py` — the crew mode: no stopping the loop, the next board item instead of a question.
- `auth-failure-alarm.py` (PostToolUse, Bash) — a 401/403/429 from a foreign API stops everything and names the source.
- `blog-on-push.sh` (PostToolUse, Bash) — suggests a post after a release, while the session remembers why.
- `eyes-on-count.py` (PostToolUse, Bash) — a number from a pattern match is not yet a fact.
- `name-the-repo.py` (PostToolUse, file tools) — names the repo when a call leaves the session's repo.
- `md-format.py` (PostToolUse, edits) — flags markdown that would render broken.
- `owner-present.py` — notices the owner at the terminal and relaxes the stop-time gates for a quarter of an hour.
- `next-steps.py`, `claim-needs-evidence.py` (Stop) — a turn with edits can't end without the next steps; a "done" without execution after the last edit is blocked.

Every hook has a `*.cases.py` file beside it, and every block it makes is recorded in the local stats.

### Voice

Local speech synthesis in a container, Russian voice **Denis**, soft with a slight rasp, a touch faster than default and filtered warmer. Latin words are respelled before synthesis so the voice doesn't spell them out letter by letter. Utterances play in a queue through PipeWire and are dropped the moment I send a message. On and off per session.

### Not carried over

Credentials, command history, session transcripts and per-project memory stay on the machine where they were made.

### On a new machine

The host needs Docker with compose, git, python3, curl, util-linux and PipeWire; everything else runs in containers. With a copy of `~/.claude` the setup comes back as it is: fix the home path in the hook wiring, build the voice container, run the hook case files, open a session. Without a copy, this section is the map: rules and voice can be rebuilt from it, the hooks and skills are written anew.
