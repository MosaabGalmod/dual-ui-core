---
name: dual-ui-core
description: Strict engineering standard for zero-leakage bilingual interfaces (Arabic RTL & English LTR), complete dual-theme support (Dark & Light modes), multi-screen responsiveness (mobile-first, container queries, fluid scaling), and accessible real-time form validation with custom notifications (zero native alerts). Trigger whenever building, styling, or reviewing any responsive web interface, form, page, or UI component.
---

# Dual-UI Core: Bilingual (AR/EN), Dual-Theme (Dark/Light) & Responsive Engineering Standard

You are an expert production frontend engineer. This standard defines non-negotiable architectural constraints for web interfaces supporting **Bilingual Localization (Arabic RTL / English LTR)**, **Dual Theme (Dark / Light)**, **Multi-Screen Responsiveness (Mobile-First)**, and **Instant Real-Time Form Validation (Zero Native Alerts)**.

When implementing or modifying any user interface, you must satisfy four fundamental pillars:
1. **Zero Text Leakage**: Arabic and English must be completely isolated. Neither language may leak into the other's view, markup, or layout.
2. **First-Class Dual Theme**: Both Dark and Light themes must be first-class citizens built on semantic CSS tokens with WCAG AA compliance, zero visual flicker (FOUC), and tactile toggle controls.
3. **Multi-Screen Responsiveness**: Mobile-first architecture, fluid scaling, container queries, ergonomic touch targets (≥44px), bidirectional-aware navigation drawers, and zero horizontal overflow.
4. **Accessible Form UX & Instant Validation**: Real-time inline field validation (`novalidate`, `:user-valid`/`:user-invalid`, `aria-describedby`), strictly localized error messages, and custom non-blocking toast notifications replacing native `window.alert()` and browser default balloons.

---

## 1. Strict Bilingual Isolation & Zero Text Leakage

### 1.1 Complete Separation of Dictionaries (No Hardcoded Strings)
- **Zero Inline Text**: No visible user-facing text, button label, tooltip, table header, error message, or placeholder may be hardcoded directly into HTML, JSX, Vue, or Svelte templates.
- **Dedicated Catalogs**: Maintain completely separate translation dictionaries:
  - `locales/ar.json` (or `const translations = { ar: { ... } }`)
  - `locales/en.json` (or `const translations = { en: { ... } }`)
- **No Language Contamination**:
  - The Arabic interface must be 100% Arabic prose. No English sentences, buttons, navigation links, or status badges may leak into the Arabic view.
  - The English interface must be 100% English prose. No Arabic words, phrases, or remnant comments may appear in the English view.
  - Exception: International technical tokens, trademarks, and protocols (e.g. `WebRTC`, `P2P`, `SHA-256`, `API`) may appear in Arabic text ONLY if wrapped in bidirectional isolation (`<bdi>` or `<span dir="ltr">`).

### 1.2 Document Level Adaptation (Direction & Typography)
Whenever the active language switches, the root document must atomically update:
```html
<!-- Arabic Mode -->
<html lang="ar" dir="rtl" class="...">
```
```html
<!-- English Mode -->
<html lang="en" dir="ltr" class="...">
```
- **Font Stack Dynamic Adaptation**:
  - In Arabic: Set primary font to an authentic Arabic typeface (e.g. `Cairo`, `Tajawal`, or `IBM Plex Sans Arabic`).
  - In English: Set primary font to a clean Latin typeface (e.g. `Inter`, `system-ui`, or `Geist`).
  - Monospace: `JetBrains Mono` or `Fira Code` for technical tokens, hashes, and code snippets across both modes.

### 1.3 Bidirectional Text & Punctuation Rules
- **Native Arabic Punctuation**:
  - In Arabic copy: Use exclusively Arabic punctuation marks: `،` (comma), `؛` (semicolon), `؟` (question mark), and `« »` (quotes).
  - Never use English `,` `;` `?` `""` inside Arabic prose.
- **Western Digits for Technical Data**:
  - Use standard Western digits `(0-9)` for versions, timestamps, file sizes, ports, and numeric IDs across both languages.
- **Bidirectional Isolation (`<bdi>`)**:
  - Every Latin term, version tag (`v1.3.44`), or metric (`161 KB`) appearing inside an Arabic paragraph or table cell MUST be enclosed in `<bdi>` or `<span dir="ltr">` to prevent text reversal and trailing punctuation bugs.

### 1.4 CSS Logical Properties (Mandatory Layout Rule)
Never use physical directional properties (`left` and `right`) for structural layout. Use **CSS Logical Properties** exclusively:

| Banned Physical Property | Required Logical Property |
|---|---|
| `margin-left` / `margin-right` | `margin-inline-start` / `margin-inline-end` |
| `padding-left` / `padding-right` | `padding-inline-start` / `padding-inline-end` |
| `left: 0` / `right: 0` | `inset-inline-start: 0` / `inset-inline-end: 0` |
| `text-align: left` / `right` | `text-align: start` / `end` |
| `border-left` / `border-right` | `border-inline-start` / `border-inline-end` |

---

## 2. Dual-Theme Architecture (Dark & Light Modes)

### 2.1 Semantic Design Tokens (CSS Variables)
Define design tokens at the root level using CSS variables. Never hardcode arbitrary hex colors directly inside component markup:

```css
:root {
  /* Light Theme (Default or [data-theme="light"]) */
  --bg-app: #ffffff;
  --bg-surface: #f4f4f5;       /* zinc-100 */
  --bg-surface-elevated: #ffffff;
  --border-subtle: #e4e4e7;     /* zinc-200 */
  --border-strong: #d4d4d8;     /* zinc-300 */
  --text-primary: #09090b;      /* zinc-950 */
  --text-secondary: #52525b;    /* zinc-600 */
  --text-muted: #71717a;        /* zinc-500 */
  --accent: #0ea5e9;            /* Sky 500 */
  --accent-contrast: #ffffff;
  --accent-subtle: #e0f2fe;     /* Sky 100 */
  --focus-ring: #0284c7;
}

[data-theme="dark"],
.dark {
  /* Dark Theme */
  --bg-app: #09090b;            /* zinc-950 */
  --bg-surface: #18181b;        /* zinc-900 */
  --bg-surface-elevated: #27272a;/* zinc-800 */
  --border-subtle: #27272a;     /* zinc-800 */
  --border-strong: #3f3f46;     /* zinc-700 */
  --text-primary: #fafafa;      /* zinc-50 */
  --text-secondary: #a1a1aa;    /* zinc-400 */
  --text-muted: #71717a;        /* zinc-500 */
  --accent: #38bdf8;            /* Sky 400 */
  --accent-contrast: #09090b;
  --accent-subtle: #082f49;     /* Sky 950 */
  --focus-ring: #38bdf8;
}
```

### 2.2 Contrast & Accessibility (WCAG AA Compliance)
- **Body Text**: Maintain minimum 4.5:1 contrast ratio against the parent background in both modes.
- **Large Headlines & Borders**: Maintain minimum 3:1 contrast ratio.
- **No Pure Black (#000) or Harsh White (#FFF) Clashing**: Soften dark backgrounds to deep zinc/slate (`#09090b`) to eliminate eye fatigue.
- **No Decorative Glowing Blobs**: Respect the Anti-AI Slop constraint—no radial colored gradient blooms in either theme.

---

## 3. Multi-Screen Responsive Architecture (Mobile-First)

### 3.1 Mobile-First Viewport & Breakpoint Standard
Always define standard viewport constraints:
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, viewport-fit=cover">
```
Build base styles for mobile viewports (`320px–639px`) first, then layer desktop layout via standard min-width breakpoints:
- `sm`: `640px` (large phones / small phablets)
- `md`: `768px` (tablets / iPad portrait)
- `lg`: `1024px` (laptops / tablet landscape)
- `xl`: `1280px` (desktop monitors)

### 3.2 Fluid Typography & 4px Spatial Grid
- Use CSS `clamp()` or stepped responsive utility classes for headlines:
  - Hero headline: `clamp(1.75rem, 5vw, 3rem)` (28–34px mobile, 44–52px desktop).
  - Body text: 15–16px across all screens.
- **Strict 4px Spatial Scale**: Maintain multiples of 4px (`4, 8, 12, 16, 24, 32, 48, 64px`) across margins and padding.

### 3.3 Touch-Ergonomic Targets
- On mobile devices, all interactive elements (buttons, links, icon toggles, form fields) must provide a minimum tappable area of **44x44px** (per WCAG 2.5.5 and Apple HIG).

### 3.4 Bidirectional-Aware Mobile Navigation (Drawer / Sheet)
- On screens `< 768px`, desktop navigation collapses into an accessible mobile hamburger trigger.
- **BiDi Sliding Rule**:
  - In Arabic (`dir="rtl"`): The mobile drawer slides in from the **right** (`inset-inline-start: 0`).
  - In English (`dir="ltr"`): The mobile drawer slides in from the **left** (`inset-inline-start: 0`).
- The drawer includes the Language and Theme controls for immediate, easy thumb access.
- Tapping outside the drawer or pressing `Escape` closes the drawer.

### 3.5 Zero Horizontal Overflow (`No Scroll Trap`)
- Document root and body must enforce `overflow-x: clip` or `overflow-x: hidden` to prevent horizontal wobble.
- Data tables, matrices, and code blocks must be wrapped in a scroll container:
  ```css
  .table-scroll-container {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    width: 100%;
  }
  ```

### 3.6 Safe Area Insets (Mobile Notches & Gesture Bars)
- Respect device notches and bottom swipe bars:
  ```css
  padding-top: env(safe-area-inset-top);
  padding-bottom: env(safe-area-inset-bottom);
  padding-inline-start: env(safe-area-inset-left);
  padding-inline-end: env(safe-area-inset-right);
  ```

### 3.7 Container Queries (`@container`) for Component Adaptability
- Decouple component responsiveness from full-viewport widths. Card grids and self-contained widgets must define container contexts:
  ```css
  .card-container {
    container-type: inline-size;
    container-name: card;
  }

  @container card (min-width: 400px) {
    .card-layout {
      display: flex;
      flex-direction: row;
      align-items: center;
    }
  }
  ```

### 3.8 Fluid CSS Grid & Auto-Fit Layout Patterns
- Eliminate brittle media-query chaining for grids. Use fluid auto-fit patterns that respond naturally to available width across phones, tablets, and desktops:
  ```css
  .responsive-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(min(100%, 280px), 1fr));
    gap: 1.5rem;
  }
  ```

### 3.9 Adaptive Complex Data & Responsive Tables
- Complex tables must adapt gracefully without breaking layouts:
  1. **Scroll Mode**: Clean horizontal scroll container with sticky logical start columns (`position: sticky; inset-inline-start: 0`).
  2. **Card Transformation Mode (Mobile-First)**: On `< 640px`, switch `display: block` on `<tr>` and render `td::before` with `attr(data-label)` to transform table rows into standalone accessible cards.

---

## 4. Form UX, Instant Real-Time Validation & Custom Notifications (Zero Native Alerts)

### 4.1 Absolute Ban on Native Alerts & Popups
- **Strictly Banned**: `window.alert()`, `window.confirm()`, and `window.prompt()` are strictly forbidden. They halt the JavaScript execution thread, violate accessible UI standards, lack theme styling, and break bidirectional continuity.
- **Banned Native Validation Balloons**: Native browser tooltip bubbles triggered by standard `required` attributes are forbidden. They produce ugly, unstyled popups that default to the operating system/browser language, leaking English or unstyled text into Arabic interfaces.
- **Mandatory `novalidate`**: Every `<form>` element must specify `novalidate` to disable browser default validation bubbles, taking full programmatic control over validation and error display:
  ```html
  <form id="contactForm" novalidate onsubmit="handleFormSubmit(event)">
  ```

### 4.2 Instant Real-Time Inline Validation Architecture
- Provide immediate, polite validation feedback as the user interacts:
  - **On Touch / Blur**: Validate field when focus leaves the input (`blur` event).
  - **Live Correction**: Once a field is marked invalid, validate on every `input` keystroke so the error disappears immediately when corrected.
  - **Modern CSS Selectors**: Leverage `:user-valid` and `:user-invalid` (or class-based state `.is-invalid` / `.is-valid`) so validation styling triggers only after user interaction, preventing premature red borders on virgin fields:
  ```css
  .form-input:user-invalid,
  .form-input.has-error {
    border-color: var(--text-error, #ef4444);
    box-shadow: 0 0 0 1px var(--text-error, #ef4444);
  }

  .form-input:user-valid:not(:placeholder-shown) {
    border-color: var(--border-strong);
  }
  ```

### 4.3 Accessible Error Anchoring & ARIA Associations
- Every input field must associate directly with its error message container:
  - Input includes `aria-invalid="false"` initially, switching to `true` upon validation failure.
  - Error element is placed directly below the field with a deterministic ID: `id="{fieldId}-error"`.
  - Input references the error ID via `aria-describedby="{fieldId}-error"`.
  - Error container uses `role="alert"` and `aria-live="polite"` so screen readers announce failures without jarring interruptions.
  ```html
  <div class="form-field space-y-1">
    <label for="userEmail" class="block text-sm font-medium text-[var(--text-primary)]">
      <span data-i18n="form.email_label">Email Address</span>
      <span class="text-red-500" aria-hidden="true">*</span>
    </label>
    
    <input type="email" 
           id="userEmail" 
           name="email" 
           required 
           aria-required="true"
           aria-invalid="false"
           aria-describedby="userEmail-error"
           class="form-input w-full px-3.5 py-2.5 rounded-lg border border-[var(--border-strong)] bg-[var(--bg-app)] text-[var(--text-primary)] text-sm focus:outline-none focus:border-[var(--focus-ring)] transition-colors min-h-[44px]">
    
    <p id="userEmail-error" 
       role="alert" 
       aria-live="polite" 
       class="hidden text-xs text-red-500 text-start mt-1 font-medium"></p>
  </div>
  ```

### 4.4 Bilingual Error Catalogs (Strict Zero Text Leakage)
- Hardcoded validation strings in JavaScript are prohibited. Validation messages must reside in language catalogs:
  ```json
  // locales/ar.json
  {
    "validation": {
      "required": "هذا الحقل مطلوب، يُرجى إدخال القيمة.",
      "email_invalid": "يرجى إدخال عنوان بريد إلكتروني صالح.",
      "min_length": "يجب ألا يقل هذا الحقل عن {min} أحرف.",
      "form_error_summary": "يرجى تصحيح الأخطاء الموضحة أدناه قبل الإرسال."
    }
  }
  ```
  ```json
  // locales/en.json
  {
    "validation": {
      "required": "This field is required. Please provide a value.",
      "email_invalid": "Please enter a valid email address.",
      "min_length": "This field must be at least {min} characters.",
      "form_error_summary": "Please correct the highlighted errors before submitting."
    }
  }
  ```

### 4.5 Production-Ready Custom Toast & Alert Notification Component
- Non-blocking, accessible notifications replacing native `alert()`:
  - Positioned logically using `inset-inline-end: 1.25rem` and `inset-block-start: 1.25rem`.
  - Accessible announcement via `role="status"` and `aria-live="polite"`.
  - Supports types: `success`, `error`, `warning`, `info` with semantic icons and theme tokens.
  - Auto-dismiss after 4000ms with manual close button and pause on hover:
  ```javascript
  function showToast(messageKey, type = 'info') {
    const container = document.getElementById('toastContainer');
    if (!container) return;

    const message = t(messageKey) || messageKey;
    const toast = document.createElement('div');
    toast.className = `custom-toast toast-${type} flex items-center gap-3 px-4 py-3 rounded-lg border shadow-lg transition-all duration-200`;
    toast.setAttribute('role', type === 'error' ? 'alert' : 'status');
    toast.innerHTML = `
      <span class="toast-message text-sm font-medium flex-1">${message}</span>
      <button onclick="this.parentElement.remove()" class="p-1 hover:opacity-70" aria-label="Close">
        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/></svg>
      </button>
    `;
    container.appendChild(toast);
    setTimeout(() => { toast.classList.add('opacity-0'); setTimeout(() => toast.remove(), 200); }, 4000);
  }
  ```

### 4.6 Custom Segmented Date Control (Mandatory for Arabic/RTL Interfaces)
- The native browser `<input type="date">` is **banned** in any Arabic (`dir="rtl"`) interface (see `arabic-bidi-engineering`, Section 3). Browsers on Windows with `ar-SA` locale force reversed field order and Arabic-Indic digits that cannot be corrected via CSS.
- **Replacement**: A custom three-segment date input with explicit RTL visual ordering, Western digits `(0-9)`, auto-advance focus, integrated calendar popup, and hidden ISO synchronization field.

#### 4.6.1 Visual Order (RTL — Right to Left)
| Position | Segment | Width | Placeholder | Label Badge |
|---|---|---|---|---|
| Far Right | Day `DD` | 2 chars | `DD` | `يوم` / `Day` |
| Center | Month `MM` | 2 chars | `MM` | `شهر` / `Month` |
| Far Left | Year `YYYY` | 4 chars | `YYYY` | `سنة` / `Year` |

Segments are separated by a visual `/` divider. A calendar button `📅` is placed at the inline-end (far left in RTL).

#### 4.6.2 Reference HTML Markup
```html
<div class="custom-date-wrapper flex items-center gap-1 border border-[var(--border-strong)] rounded-lg bg-[var(--bg-app)] px-3 py-2 min-h-[44px]"
     dir="ltr">
  <!-- Force LTR inside the control so segments stay DD / MM / YYYY visually left-to-right,
       while the outer form remains RTL. The label and field-group order in the form handles RTL placement. -->

  <div class="segment-group flex items-center gap-1">
    <!-- Day -->
    <div class="flex flex-col items-center">
      <input type="text" id="dateDay" inputmode="numeric" maxlength="2" placeholder="DD"
             aria-label="Day" autocomplete="off"
             class="w-8 text-center text-sm font-mono bg-transparent border-none outline-none text-[var(--text-primary)] placeholder:text-[var(--text-muted)]">
      <span class="text-[10px] text-[var(--text-muted)] leading-none mt-0.5" data-i18n="date.day_label">يوم</span>
    </div>

    <span class="text-[var(--text-muted)] text-sm select-none">/</span>

    <!-- Month -->
    <div class="flex flex-col items-center">
      <input type="text" id="dateMonth" inputmode="numeric" maxlength="2" placeholder="MM"
             aria-label="Month" autocomplete="off"
             class="w-8 text-center text-sm font-mono bg-transparent border-none outline-none text-[var(--text-primary)] placeholder:text-[var(--text-muted)]">
      <span class="text-[10px] text-[var(--text-muted)] leading-none mt-0.5" data-i18n="date.month_label">شهر</span>
    </div>

    <span class="text-[var(--text-muted)] text-sm select-none">/</span>

    <!-- Year -->
    <div class="flex flex-col items-center">
      <input type="text" id="dateYear" inputmode="numeric" maxlength="4" placeholder="YYYY"
             aria-label="Year" autocomplete="off"
             class="w-12 text-center text-sm font-mono bg-transparent border-none outline-none text-[var(--text-primary)] placeholder:text-[var(--text-muted)]">
      <span class="text-[10px] text-[var(--text-muted)] leading-none mt-0.5" data-i18n="date.year_label">سنة</span>
    </div>
  </div>

  <!-- Calendar Popup Trigger -->
  <button type="button" id="dateCalendarBtn" aria-label="Open calendar"
          class="p-1 ms-1 text-[var(--accent)] hover:text-[var(--text-primary)] transition-colors">
    📅
  </button>

  <!-- Hidden native date input for calendar popup & form submission (ISO YYYY-MM-DD) -->
  <input type="date" id="dateHidden" class="sr-only" tabindex="-1" aria-hidden="true">
  <input type="hidden" id="dateISO" name="date_value">
</div>
```

#### 4.6.3 JavaScript Behavior Specification
```javascript
function initSegmentedDate(dayId, monthId, yearId, hiddenISOId, calendarBtnId, hiddenDateId) {
  const day = document.getElementById(dayId);
  const month = document.getElementById(monthId);
  const year = document.getElementById(yearId);
  const iso = document.getElementById(hiddenISOId);
  const calBtn = document.getElementById(calendarBtnId);
  const hiddenDate = document.getElementById(hiddenDateId);
  const segments = [day, month, year];

  // Allow only digits
  segments.forEach(seg => {
    seg.addEventListener('input', () => {
      seg.value = seg.value.replace(/\D/g, '');
    });
  });

  // Auto-advance: day→month after 2 digits, month→year after 2 digits
  day.addEventListener('input', () => {
    if (day.value.length === 2) month.focus();
    syncISO();
  });
  month.addEventListener('input', () => {
    if (month.value.length === 2) year.focus();
    syncISO();
  });
  year.addEventListener('input', () => syncISO());

  // Backspace retreat: empty month→day, empty year→month
  month.addEventListener('keydown', e => {
    if (e.key === 'Backspace' && month.value === '') { e.preventDefault(); day.focus(); }
  });
  year.addEventListener('keydown', e => {
    if (e.key === 'Backspace' && year.value === '') { e.preventDefault(); month.focus(); }
  });

  // Calendar popup: open hidden native picker, reflect selection
  calBtn.addEventListener('click', () => hiddenDate.showPicker());
  hiddenDate.addEventListener('change', () => {
    if (!hiddenDate.value) return;
    const [y, m, d] = hiddenDate.value.split('-');
    day.value = d;
    month.value = m;
    year.value = y;
    syncISO();
  });

  function syncISO() {
    const d = day.value.padStart(2, '0');
    const m = month.value.padStart(2, '0');
    const y = year.value.padStart(4, '0');
    iso.value = (y !== '0000' && m !== '00' && d !== '00') ? `${y}-${m}-${d}` : '';
  }
}

// Initialize on DOM ready
document.addEventListener('DOMContentLoaded', () => {
  initSegmentedDate('dateDay', 'dateMonth', 'dateYear', 'dateISO', 'dateCalendarBtn', 'dateHidden');
});
```

#### 4.6.4 Bilingual Date Labels (Zero Text Leakage)
Add to language catalogs:
```json
// locales/ar.json
{
  "date": {
    "day_label": "يوم",
    "month_label": "شهر",
    "year_label": "سنة",
    "open_calendar": "فتح التقويم",
    "date_required": "يرجى إدخال التاريخ كاملاً.",
    "date_invalid": "التاريخ المُدخل غير صالح."
  }
}
```
```json
// locales/en.json
{
  "date": {
    "day_label": "Day",
    "month_label": "Month",
    "year_label": "Year",
    "open_calendar": "Open calendar",
    "date_required": "Please enter a complete date.",
    "date_invalid": "The entered date is not valid."
  }
}
```

---

## 5. Interactive Toggle Controls & Anti-FOUC State

### 5.1 Anti-FOUC Hydration Script (Zero Visual Glitch)
To eliminate Flash of Unstyled Content (FOUC) or Flash of Wrong Language upon page refresh, insert this tiny, synchronous script into the document `<head>` **before** any stylesheet or body tag:

```html
<script>
  (function() {
    // 1. Language hydration
    var savedLang = localStorage.getItem('app_lang') || 
                    (navigator.language && navigator.language.startsWith('ar') ? 'ar' : 'en');
    document.documentElement.lang = savedLang;
    document.documentElement.dir = savedLang === 'ar' ? 'rtl' : 'ltr';

    // 2. Theme hydration
    var savedTheme = localStorage.getItem('app_theme') || 
                     (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    document.documentElement.setAttribute('data-theme', savedTheme);
    if (savedTheme === 'dark') {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  })();
</script>
```

### 5.2 Accessible Language Toggle Button
```html
<button id="langToggleBtn" 
        onclick="toggleLanguage()"
        class="inline-flex items-center gap-2 px-3 py-1.5 min-h-[44px] sm:min-h-[36px] rounded-lg border border-[var(--border-subtle)] bg-[var(--bg-surface)] text-[var(--text-secondary)] hover:text-[var(--text-primary)] hover:border-[var(--border-strong)] transition-colors text-xs font-semibold"
        aria-label="Switch Language / تبديل اللغة">
  <svg class="w-4 h-4 text-[var(--accent)]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75" d="M12 21a9 9 0 100-18 9 9 0 000 18zm0 0c2.5 0 4.5-4 4.5-9s-2-9-4.5-9m0 18c-2.5 0-4.5-4-4.5-9s2-9 4.5-9m-9 9h18"/>
  </svg>
  <span id="langBtnLabel">English</span>
</button>
```

### 5.3 Accessible Theme Toggle Button
```html
<button id="themeToggleBtn"
        onclick="toggleTheme()"
        class="p-2 min-h-[44px] min-w-[44px] sm:min-h-[36px] sm:min-w-[36px] flex items-center justify-center rounded-lg border border-[var(--border-subtle)] bg-[var(--bg-surface)] text-[var(--text-secondary)] hover:text-[var(--text-primary)] hover:border-[var(--border-strong)] transition-colors"
        aria-label="Toggle Dark/Light Mode"
        title="Toggle Theme">
  <svg id="themeIconSun" class="w-4 h-4 hidden dark:block text-[var(--accent)]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
  </svg>
  <svg id="themeIconMoon" class="w-4 h-4 block dark:hidden text-[var(--accent)]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
  </svg>
</button>
```

---

## 6. Pre-Delivery Quality Checklist (16 Verification Checks)

Before concluding any UI delivery or component refactoring, verify every item:

| # | Inspection Item | Required Verdict |
|---|---|:---:|
| 1 | Are all texts stored in isolated `ar` and `en` dictionaries (zero hardcoded strings)? | YES |
| 2 | Does switching to Arabic leave zero English words or remnant phrases behind? | YES |
| 3 | Does switching to English leave zero Arabic words or characters behind? | YES |
| 4 | Are Latin tokens/acronyms (`v1.0`, `WebRTC`, `P2P`) inside Arabic text wrapped in `<bdi>`? | YES |
| 5 | Does the document root toggle `lang="ar"` + `dir="rtl"` vs `lang="en"` + `dir="ltr"`? | YES |
| 6 | Are all layout margins/paddings built using CSS Logical Properties (`start`/`end`)? | YES |
| 7 | Does the page render with zero theme/language flicker (Anti-FOUC script present)? | YES |
| 8 | Does the Theme Toggle switch cleanly between Dark and Light mode without layout shift? | YES |
| 9 | Do both Dark and Light themes pass WCAG AA contrast (≥ 4.5:1 for body text)? | YES |
| 10 | Is the layout 100% responsive across mobile (`320px+`), tablet, and desktop viewports? | YES |
| 11 | Do all touch targets on mobile meet the minimum 44x44px ergonomic threshold? | YES |
| 12 | Does the mobile navigation drawer slide in from the correct logical direction (RTL vs LTR)? | YES |
| 13 | Are `window.alert()`, `confirm()`, and default browser validation popups completely eliminated? | YES |
| 14 | Do all forms enforce `novalidate` with instant inline field validation and `aria-describedby`? | YES |
| 15 | Are form validation messages 100% localized in `locales/ar.json` and `locales/en.json`? | YES |
| 16 | Are responsive container queries (`@container`) or fluid auto-fit grids used for modular layout? | YES |
| 17 | Are all date inputs replaced with Custom Segmented Date Controls (no native `<input type="date">` in RTL)? | YES |
