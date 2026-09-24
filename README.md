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

How I work with an AI coding assistant (Claude Code): the rules it follows, the hooks that enforce them, the skills it loads, and a local voice. This section describes the setup; the files themselves live in `~/.claude`.

### Layout

```
~/.claude/
  CLAUDE.md          core rules, loaded into every session (30 numbered rules)
  settings.json      permissions, model, effort, hook wiring
  hooks/             15 hooks that enforce the rules mechanically, with test cases
  scripts/           session clock, blog counter and their tests
  skills/            8 skills: session-start, git-workflow, review-panel, docs-pairing,
                     foreign-repos, workbench, blog-post, voice
  agents/verifier.md read-only adversarial checker
  tts/               local voice: speech synthesis in a container, playback queue, on/off
  stats/             local statistics: hook blocks and sessions, charts
```

### Rules

A summary. The rules themselves are in `CLAUDE.md`, in Russian.

**How we work**
- Ask briefly before anything that changes files or outside state, unless I already said "go" for this block of work.
- Do everything a script, CLI or API can do; leave me only accounts, payments, credentials and UI toggles.
- Unclear even by a percent — ask. A slow wrong guess costs more than a question.
- Before a task: a numbered checklist, confirmed, ticked off as it closes.
- No ad-hoc commands: write a script, run only the script, debug by editing it. Every command carries a plain description of what it does and what we expect.
- An answer to my question is an answer, not a command. "Yes" or a picked option closes the question; it does not start the edit.

**How it answers**
- Answers in Russian; code, comments and commit messages in English, no filler.
- Discussing a change means showing the code: snippet, before/after, exact `file:line`.
- Choices go through an interactive question form, never prose. Every option names the place, the consequence and the price. An option without all three is a label, not an option. No yes/no questions, and no questions after the work is done.
- A finished piece ends with what to take next, as a form, ordered by what fires first — not after a plain answer, and not when only one next step is obvious.
- The first line is the conclusion. Anything with a level of importance gets a colour marker: 🔴 critical, 🟠 caveat, 🟡 defect, 🟢 done and machine-checked, 🟣 fact, ⚪ deferred.
- Anything an agent said is attributed and marked verified (with how) or not verified. A finding that failed verification is not repeated at all.
- Code outside the session's repo is named by repo or package, never "the SDK" or "the library".
- A status line closes every answer: date, time and session age, branch, uncommitted files, background jobs.

**What we don't do**
- No commits or pushes without an explicit word, and no asking whether it's time.
- No invented API fields or behaviour. If something was added that the API lacks, it is said plainly.
- Nothing is installed on the host — only inside Docker.
- No merge request suggestions. Work projects' CI/CD is not ours to write, edit or propose.

**Checking itself**
- Numbers are recounted by a script, not remembered.
- Claims about a database, framework or library are checked by an experiment in a container.
- A checklist item is closed only after a machine check.
- A large piece goes through a panel of independent reviewer agents before it is called done; the security lens is mandatory.
- "Done" only after execution, and execution after the last edit.
- Documents come in pairs, Russian and English.

**Time**
- Date and time come from a script, not from memory.
- A new session starts by reporting where we are, not by editing.
- Older than 6 hours: re-read rules, skills, hooks and memory from disk before acting.
- Older than 8 hours: save a handoff and stop until restart.

**Voice**
- With `/voice on`, everything in Russian is spoken: command descriptions and question forms by a hook, the rest by the assistant itself. Code, commands, paths and the status line are not spoken. Picking an option or pressing Enter silences it at once.

### Hooks

- `session-start.sh` (SessionStart) — date, branch, uncommitted files and what changed since the last start.
- `blog-due.sh` (SessionStart) — reminds when it's time for a blog post.
- `voice-hush.py` (UserPromptSubmit) — Enter silences the voice.
- `session-stop.py` (PreToolUse, any) — after 8 hours the session saves a handoff and stops.
- `guard-push.sh` (PreToolUse, Bash) — a push names its target; a shared branch needs my approval.
- `guard-commit.sh` (PreToolUse, Bash) — document pairs and fresh lock files before a commit.
- `speak.py` (PreToolUse, Bash + question) — speaks command descriptions and question forms.
- `guard-question.py` (PreToolUse, question) — rejects options that don't say what they cost.
- `speak-stop.sh` (PostToolUse, question) — an answer picked, the voice stops.
- `blog-on-push.sh` (PostToolUse, Bash) — suggests a post after a release, while the session remembers why.
- `eyes-on-count.py` (PostToolUse, Bash) — a number from a pattern match is not yet a fact.
- `name-the-repo.py` (PostToolUse, file tools) — names the repo when a call leaves the session's repo.
- `md-format.py` (PostToolUse, edits) — flags markdown that would render broken.
- `next-steps.py` (Stop) — a turn with edits or a commit can't end without the next steps.
- `claim-needs-evidence.py` (Stop) — a "done" without execution after the last edit is blocked.

### Voice

Local speech synthesis in a container, Russian voice **Denis**, soft with a slight rasp, a touch faster than default and filtered warmer. Latin words are respelled before synthesis so the voice doesn't spell them out letter by letter. Utterances play in a queue through PipeWire and are dropped the moment I send a message. On and off per session with `/voice`.

### Not carried over

Credentials, command history, session transcripts and per-project memory stay on the machine where they were made.

### On a new machine

The host needs Docker with compose, git, python3, curl, util-linux and PipeWire; everything else runs in containers. With a copy of `~/.claude` the setup comes back as it is: fix the home path in the hook wiring, build the voice container, run the hook test cases, open a session. Without a copy, this section is the map: rules and voice can be rebuilt from it, the hooks and skills are written anew.
