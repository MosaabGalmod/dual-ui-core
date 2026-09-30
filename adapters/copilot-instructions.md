# GitHub Copilot Instructions: Dual-UI Core Standards

When generating or refactoring bilingual (Arabic/English) or themed (Dark/Light) interfaces:

1. **Bilingual Zero-Leakage**:
   - Store all UI strings in `ar` and `en` dictionaries.
   - Never write raw text into HTML or JSX.
   - Use CSS Logical Properties (`margin-inline-start`, `text-align: start`).
   - Isolate Latin tokens in Arabic with `<bdi>`.

2. **Dual-Theme Tokens**:
   - Use CSS variables for surface, text, and border colors.
   - Maintain WCAG AA contrast (≥ 4.5:1 for text).

3. **Interactive Controls**:
   - Implement Language and Theme toggle buttons with `localStorage` persistence.
   - Ensure an anti-FOUC script executes in `<head>` before rendering.
