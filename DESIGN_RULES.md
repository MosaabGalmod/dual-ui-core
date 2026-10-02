# Dual-UI Core: Production Design Rules (Bilingual, Dual-Theme & Responsive)

> Drop this file into your repository root as `DESIGN_RULES.md`, or paste it into `CLAUDE.md`, `GEMINI.md`, or `.cursorrules`.

You are building a production web interface. The following rules are non-negotiable architectural constraints for bilingual (Arabic RTL & English LTR) interfaces supporting both Dark and Light themes across all screen sizes:

---

### 1. Bilingual Architecture & Zero Text Leakage
- **No Hardcoded Copy**: All user-facing strings must reside in isolated dictionaries (`ar` and `en`). Hardcoding copy directly in component markup is strictly forbidden.
- **Strict Isolation**:
  - In Arabic mode: zero English phrases, buttons, badges, or placeholders may appear (except Latin technical acronyms isolated inside `<bdi>`).
  - In English mode: zero Arabic characters or leftover words may appear.
- **Bidirectional Text Punctuation**:
  - In Arabic: use Arabic punctuation `،` `؛` `؟` and `« »`.
  - In English: use English punctuation `,` `;` `?` and `""`.
  - Western digits `0-9` for technical metrics and version tags across both languages.
- **CSS Logical Properties**: Always use `margin-inline-start`, `padding-inline-end`, `text-align: start`. Physical `left`/`right` properties for layout structure are prohibited.
- **Font Stack Dynamic Adaptation**:
  - Arabic: Authentic Arabic typeface (`Cairo` / `Tajawal` / `IBM Plex Sans Arabic`).
  - English: Clean Latin typeface (`Inter` / `system-ui` / `Geist`).
  - Code/Metrics: `JetBrains Mono` or `Fira Code`.

---

### 2. Dual-Theme Architecture (Dark & Light)
- **Token-Based Theming**: Use CSS custom properties (`:root` for light mode, `[data-theme="dark"]` / `.dark` for dark mode). Never inline arbitrary one-off color hex codes.
- **Surface Steps**:
  - Dark: Background `#09090b` (deep zinc), Cards `#18181b`, Borders `#27272a`, Text `#fafafa`.
  - Light: Background `#ffffff`, Cards `#f4f4f5`, Borders `#e4e4e7`, Text `#09090b`.
- **WCAG AA Compliance**: Ensure a minimum contrast ratio of 4.5:1 for standard body text and 3:1 for large text/interactive borders across both themes.
- **Anti-AI Slop Alignment**: No radial colored gradient blooms or fake drop-shadows on stationary cards in either theme.

---

### 3. Multi-Screen Responsive Architecture (Mobile-First & Modern Patterns)
- **Mobile-First Breakpoints**: Base styles for small screens (`320px–639px`) first, then layer enhancements at `sm: 640px`, `md: 768px`, `lg: 1024px`, `xl: 1280px`.
- **Container Queries (`@container`)**: Isolate card and component responsiveness from global viewport widths so components adapt modularly.
- **Fluid CSS Grid Patterns**: Employ `grid-template-columns: repeat(auto-fit, minmax(min(100%, 280px), 1fr))` to avoid media query bloat.
- **Ergonomic Touch Targets**: Minimum 44x44px tappable target on mobile for all buttons, links, and toggles.
- **BiDi Mobile Drawer Navigation**: Collapse navigation links on `< 768px` into an accessible drawer that slides in from `inset-inline-start` (right in Arabic, left in English).
- **Fluid Typography**: Use `clamp()` for headline typography to prevent awkward line breaks on mobile screens.
- **Adaptive Data Tables**: Wrap tables in horizontal scroll containers with sticky start columns, or transform rows into cards (`data-label`) on mobile.
- **Zero Horizontal Overflow**: Prevent horizontal page wobble (`overflow-x: clip`).
- **Safe Area Insets**: Accommodate device notches and bottom bars using `env(safe-area-inset-*)`.

---

### 4. State Management & Controls
- **Language Toggle**: Accessible button showing current and target language, instant DOM text hydration without full-page reloads, persisted in `localStorage`.
- **Theme Toggle**: Accessible button with clear Sun/Moon iconography, smooth 120-160ms transition, persisted in `localStorage` and synchronized with `prefers-color-scheme`.
- **Anti-FOUC Head Script**: Include an inline script in `<head>` to read `localStorage` and set `dir`, `lang`, and theme attributes before visual paint.

---

### 5. Form UX, Instant Real-Time Validation & Custom Notifications (Zero Native Alerts)
- **Banned Native Blocking Alerts**: `window.alert()`, `window.confirm()`, and `window.prompt()` are strictly forbidden. Use non-blocking, accessible toast notifications with auto-dismiss and ARIA live regions.
- **Banned Native Required Popups**: Browser default tooltip balloons on `required` inputs are forbidden. Forms must include `novalidate`.
- **Instant Inline Validation**: Provide immediate feedback on `blur` and live correction on `input`, using `:user-valid` / `:user-invalid` or state classes to avoid premature error styling.
- **Accessible Error Anchoring**: Every error resides directly beneath the input, connected via `aria-describedby="{id}-error"` and `aria-invalid="true"`.
- **Bilingual Error Catalogs**: Zero hardcoded error strings in JS. All validation messages must be fetched from `locales/ar.json` and `locales/en.json` (Zero Text Leakage).
