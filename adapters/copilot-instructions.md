# GitHub Copilot Instructions: Dual-UI Core Standards

When generating or refactoring bilingual (Arabic/English), themed (Dark/Light), or responsive interfaces:

1. **Bilingual Zero-Leakage**:
   - Store all UI strings in `ar` and `en` dictionaries. Never write raw text into HTML or JSX.
   - Use CSS Logical Properties (`margin-inline-start`, `text-align: start`).
   - Isolate Latin tokens in Arabic with `<bdi>`.
   - Follow 15-point Arabic/RTL rules and Flip Test in `arabic-bidi-engineering` (Section 5) as normative.

2. **Dual-Theme Tokens**:
   - Use CSS variables for surface, text, and border colors.
   - Maintain WCAG AA contrast (≥ 4.5:1 for text).
   - Apply 60-30-10 colour distribution (~60% neutral surfaces, ~30% brand, ~10% accent fill with dark text for primary CTAs). In dark theme, re-derive tokens with same proportions.

3. **Multi-Screen Responsiveness**:
   - Design mobile-first with standard breakpoints (640px, 768px, 1024px, 1280px).
   - Ensure minimum 44x44px touch targets on mobile.
   - Ensure mobile navigation drawer slides in from the logical start edge (right in RTL, left in LTR).
   - Avoid horizontal overflow (`overflow-x: clip`).

4. **Interactive Controls**:
   - Implement Language and Theme toggle buttons with `localStorage` persistence.
   - Ensure an anti-FOUC script executes in `<head>` before rendering.
