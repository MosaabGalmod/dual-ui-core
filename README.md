# Dual-UI Core: Universal Bilingual (AR/EN), Dual-Theme & Responsive Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Universal Agents](https://img.shields.io/badge/Universal%20Agents-Antigravity%20%7C%20Claude%20Code%20%7C%20Codex%20%7C%20Cursor%20%7C%20Windsurf%20%7C%20Cline%20%7C%20Copilot-success.svg)](#installation)

> **Strict zero-leakage bilingual architecture (Arabic RTL / English LTR), native dual-theme support (Dark & Light modes), and robust multi-screen responsiveness (Mobile-First) for autonomous coding agents.**
>
> **مهارة ومعيار هندسي شامل لإنتاج واجهات ويب ثنائية اللغة (عربي RTL وإنجليزي LTR) مع عزل تام يمنع تسرب أي لغة للأخرى، ودعم أصيل للنمطين الداكن والفاتح، واستجابة تامة لكافة مقاسات الشاشات (الهواتف، الأجهزة اللوحية، والشاشات العريضة) مع أزرار التحكم وحفظ التفضيلات.**

---

## The Four Core Pillars (الركائز الهندسية الأربع)

### 1. Zero Text Leakage (العزل اللغوي التام)
- Dictionaries are strictly separated (`locales/ar.json` and `locales/en.json`).
- Zero hardcoded strings in templates or components.
- The Arabic view contains **zero** English words or buttons (except technical acronyms wrapped in `<bdi>`).
- The English view contains **zero** Arabic words or remnant characters.
- Punctuation rules: Arabic punctuation `،` `؛` `؟` `« »` in Arabic, Western punctuation `,` `;` `?` `""` in English.
- Western digits `0-9` for technical metrics and version tags across both languages.
- CSS Logical Properties: `margin-inline-start`, `padding-inline-end`, and `text-align: start`.

### 2. First-Class Dual-Theme (النمطان الداكن والفاتح)
- Calibrated semantic design tokens via CSS variables.
- WCAG AA compliance (minimum 4.5:1 text contrast).
- Soft, ergonomic zinc/slate steps (no blinding white or pitch black clashing).
- Anti-FOUC script in `<head>` to eliminate visual flash of wrong language or theme upon load.

### 3. Multi-Screen Responsiveness (التجاوب الكامل مع كافة الشاشات)
- **Mobile-First Foundation**: Base styles for small screens (`320px–639px`) first, then progressively layered via standard breakpoints (`sm: 640px`, `md: 768px`, `lg: 1024px`, `xl: 1280px`).
- **Container Queries (`@container`)**: Isolate card and component responsiveness from global viewport widths.
- **Fluid CSS Grid**: Auto-fit layouts `grid-template-columns: repeat(auto-fit, minmax(min(100%, 280px), 1fr))` preventing media query bloat.
- **Touch-Ergonomic Targets**: Minimum 44x44px clickable target on mobile for all buttons, links, and icon toggles (WCAG 2.5.5 / Apple HIG).
- **BiDi Adaptive Navigation Drawer**: On screens `< 768px`, desktop navigation collapses into a slide-out drawer that slides in from `inset-inline-start` (from the right in Arabic RTL, from the left in English LTR).
- **Fluid Typography**: Uses `clamp()` for headline typography to prevent awkward line breaks on narrow phone screens.
- **Adaptive Tables & Zero Horizontal Overflow**: Prohibits horizontal window scroll (`overflow-x: clip`), with card transformation or horizontal scroll containers for data tables.
- **Safe Area Insets**: Accommodates mobile notches and gesture navigation swipe bars using `env(safe-area-inset-*)`.

### 4. Form UX & Instant Real-Time Validation (التحقق الفوري والتنبيهات المخصصة)
- **Zero Native Alerts**: Complete elimination of blocking `window.alert()`, `window.confirm()`, and unstyled browser default `required` tooltip balloons.
- **Mandatory `novalidate`**: Forms enforce programmatic control with instant inline field feedback on `blur` and live correction on `input`.
- **CSS-Native Selectors**: Utilizes `:user-valid` and `:user-invalid` preventing premature error styling.
- **Accessible Error Anchoring**: Every input connects directly to its underlying error container via `aria-describedby` and `aria-invalid="true"`.
- **Bilingual Validation Catalogs**: 100% of error messages are fetched from `locales/ar.json` and `locales/en.json` (Zero Text Leakage).
- **Custom Accessible Toasts**: Non-blocking, theme-aware notifications with ARIA live regions and logical direction positioning.

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
│   └── index.html            # Complete working zero-dependency demonstration (Responsive + BiDi + Themes)
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
- [ ] 10. Is the layout 100% responsive across mobile (`320px+`), tablet, and desktop viewports?
- [ ] 11. Do all touch targets on mobile meet the minimum 44x44px ergonomic threshold?
- [ ] 12. Does the mobile navigation drawer slide in from the correct logical direction (RTL vs LTR)?

---

## License

This project is licensed under the [MIT License](LICENSE) — free to use in personal, open-source, and commercial projects.
