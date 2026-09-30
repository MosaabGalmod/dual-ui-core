# AGENTS.md: Universal Agent Standard for Bilingual (AR/EN), Dual-Theme & Responsive UI

> This document defines the engineering protocol for any AI coding agent building or modifying web applications with bilingual Arabic/English, Dark/Light mode, and multi-screen responsive capabilities.

## System Directives for Agents

When implementing, refactoring, or generating web pages and UI components, you must adhere strictly to these non-negotiable rules:

---

### 1. Bilingual Architecture & Zero Text Leakage
- **No Hardcoded Copy**: All user-facing strings must reside in isolated dictionaries (`ar` and `en`). Hardcoded text in HTML/JSX/Vue is a defect.
- **Strict Isolation**: 
  - When in Arabic mode: zero English phrases, buttons, badges, or placeholders may appear (except Latin technical acronyms isolated inside `<bdi>`).
  - When in English mode: zero Arabic characters, words, or comments may appear.
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

### 2. Dual-Theme Engineering (Dark & Light)
- **Token-Based Theming**: Use CSS custom properties (`:root` for light mode, `[data-theme="dark"]` / `.dark` for dark mode). Never inline arbitrary one-off color hex codes.
- **Surface Steps**:
  - Dark: Background `#09090b` (deep zinc), Cards `#18181b`, Borders `#27272a`, Text `#fafafa`.
  - Light: Background `#ffffff`, Cards `#f4f4f5`, Borders `#e4e4e7`, Text `#09090b`.
- **WCAG AA Compliance**: Ensure a minimum contrast ratio of 4.5:1 for standard body text and 3:1 for large text/interactive borders across both themes.
- **No Heavy Glowing Blobs**: Adhere to Anti-AI Slop principles—avoid radial decorative blurred blobs in both themes.

---

### 3. Multi-Screen Responsive Architecture (Mobile-First)
- **Mobile-First Layout**: Design base styles for small screens (`320px–639px`) first, then progressively enhance using standard breakpoints (`sm: 640px`, `md: 768px`, `lg: 1024px`, `xl: 1280px`).
- **Touch-Ergonomic Targets**: Ensure a minimum 44x44px tappable target on mobile for all buttons, toggles, and navigation links.
- **BiDi Responsive Navigation**: Collapse desktop navigation into an accessible mobile drawer on screens `< 768px`. The drawer must slide in from `inset-inline-start` (from the right in Arabic RTL, from the left in English LTR).
- **Fluid Typography**: Use `clamp()` for headline typography (e.g. `clamp(1.75rem, 4vw, 2.75rem)`) to prevent awkward line breaks on mobile.
- **Zero Horizontal Overflow**: Enforce `overflow-x: clip` or `hidden` on the document root, and wrap tables and wide data blocks in horizontal scroll containers.
- **Safe Area Insets**: Support device notches and home indicator swipe bars using `env(safe-area-inset-*)`.

---

### 4. State Management & Toggle Controls
- **Language Toggle**: Accessible button showing current and target language, instant DOM text hydration via `data-i18n` without full-page reloads, persisted in `localStorage`.
- **Theme Toggle**: Accessible button with clear Sun/Moon iconography, smooth 120-160ms transition, persisted in `localStorage` and synchronized with `prefers-color-scheme`.
- **Anti-FOUC Head Script**: Include an inline script in `<head>` to read `localStorage` and set `dir`, `lang`, and theme attributes before visual paint.
