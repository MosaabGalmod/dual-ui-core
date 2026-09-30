# Dual-UI Core: Universal Bilingual (AR/EN) & Dual-Theme (Dark/Light) Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Universal Agents](https://img.shields.io/badge/Universal%20Agents-Antigravity%20%7C%20Claude%20Code%20%7C%20Codex%20%7C%20Cursor%20%7C%20Windsurf%20%7C%20Cline%20%7C%20Copilot-success.svg)](#installation)

> **Strict zero-leakage bilingual architecture (Arabic RTL / English LTR) with native dual-theme support (Dark & Light modes) for autonomous coding agents.**
>
> **مهارة ومعيار هندسي شامل لإنتاج واجهات ويب ثنائية اللغة (عربي RTL وإنجليزي LTR) مع عزل تام يمنع تسرب أي لغة للأخرى، ودعم أصيل للنمطين الداكن والفاتح مع أزرار التحكم وحفظ التفضيلات.**

---

## Core Pillars (الركائز الأساسية للمهارة)

1. **Zero Text Leakage (العزل التام لمنع تسرب النصوص)**:
   - Dictionaries are strictly separated (`locales/ar.json` and `locales/en.json`).
   - Zero hardcoded strings in templates or components.
   - The Arabic view contains **zero** English words or buttons (except technical acronyms wrapped in `<bdi>`).
   - The English view contains **zero** Arabic words or remnant characters.
   - Punctuation rules: Arabic punctuation `،` `؛` `؟` `« »` in Arabic, Western punctuation `,` `;` `?` `""` in English.
   - Western digits `0-9` for technical metrics and version tags across both languages.

2. **CSS Logical Properties (الهندسة المنطقية للاتجاه)**:
   - Strict use of `margin-inline-start`, `padding-inline-end`, and `text-align: start`.
   - Never use physical `left` or `right` for structural layout.

3. **First-Class Dual-Theme (Dark & Light Modes)**:
   - Calibrated semantic design tokens via CSS variables.
   - WCAG AA compliance (minimum 4.5:1 text contrast).
   - No blinding pure white or pitch black clashing; soft ergonomic zinc/slate steps.

4. **Interactive Controls & Anti-FOUC (التحكم السلس وانعدام الوميض)**:
   - Interactive Language Toggle button (instant switch without page reload).
   - Interactive Theme Toggle button (dynamic Sun/Moon with 140ms ease-out transition).
   - Anti-FOUC script in `<head>` to eliminate visual flash of wrong language or theme upon load.
   - State persistence in `localStorage`.

---

## Repository Structure (هيكل المشروع)

```text
dual-ui-core/
├── SKILL.md                  # Autonomous agent skill for Antigravity & Claude Code
├── AGENTS.md                 # Universal open standard for OpenAI Codex & coding agents
├── DESIGN_RULES.md           # Standalone raw rules for system prompts and constitution
├── install.ps1               # 1-Click universal installer for Windows (PowerShell)
├── install.sh                # 1-Click universal installer for macOS / Linux (Bash)
├── templates/
│   └── index.html            # Complete working zero-dependency demonstration
├── adapters/
│   ├── .cursorrules          # Turnkey adapter for Cursor IDE
│   ├── .windsurfrules        # Turnkey adapter for Windsurf / Cascade
│   ├── .clinerules           # Turnkey adapter for Cline & Roo Code
│   └── copilot-instructions  # Turnkey adapter for GitHub Copilot
├── README.md                 # Bilingual documentation
└── LICENSE                   # MIT License
```

---

## ⚡ 1-Click Installation (التثبيت السريع بأمر واحد)

### Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/install.ps1 | iex
```

### macOS / Linux (Bash):
```bash
curl -fsSL https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/install.sh | bash
```

---

## Manual Agent Setup (الإعداد اليدوي)

### 1. Google Antigravity & Gemini CLI (`agy`)
```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.gemini\config\skills\dual-ui-core"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/SKILL.md" -OutFile "$HOME\.gemini\config\skills\dual-ui-core\SKILL.md"
```

### 2. Claude Code
#### Windows (PowerShell):
```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills\dual-ui-core"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/SKILL.md" -OutFile "$HOME\.claude\skills\dual-ui-core\SKILL.md"
```

#### macOS / Linux (Bash):
```bash
mkdir -p ~/.claude/skills/dual-ui-core
curl -sSL https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/SKILL.md -o ~/.claude/skills/dual-ui-core/SKILL.md
```

### 3. OpenAI Codex & Universal Agents (`AGENTS.md`)
Drop `AGENTS.md` into the root of any repository:
```bash
curl -sSL https://raw.githubusercontent.com/MosaabGalmod/dual-ui-core/main/AGENTS.md -o AGENTS.md
```

### 4. Cursor / Windsurf / Cline
Copy the appropriate adapter from the `adapters/` folder into your project root.

---

## Pre-Delivery Quality Checklist (قائمة التحقق قبل التسليم)

- [ ] 1. Are all strings stored in isolated `ar` and `en` dictionaries (zero hardcoded strings)?
- [ ] 2. Does switching to Arabic leave zero English words or remnant phrases behind?
- [ ] 3. Does switching to English leave zero Arabic words or characters behind?
- [ ] 4. Are Latin tokens/acronyms inside Arabic text wrapped in `<bdi>`?
- [ ] 5. Does the document root toggle `lang="ar"` + `dir="rtl"` vs `lang="en"` + `dir="ltr"`?
- [ ] 6. Are all layout margins/paddings built using CSS Logical Properties (`start`/`end`)?
- [ ] 7. Does the page render with zero theme/language flicker (Anti-FOUC script present)?
- [ ] 8. Does the Theme Toggle switch cleanly between Dark and Light mode without layout shift?
- [ ] 9. Do both Dark and Light themes pass WCAG AA contrast (≥ 4.5:1 for body text)?
- [ ] 10. Are user choices for language and theme persisted in `localStorage` across reloads?

---

## License

This project is licensed under the [MIT License](LICENSE) — free to use in personal, open-source, and commercial projects.
