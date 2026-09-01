---
name: Deep Emerald
colors:
  surface: '#031712'
  surface-dim: '#031712'
  surface-bright: '#293d37'
  surface-container-lowest: '#00110d'
  surface-container-low: '#0a1f1a'
  surface-container: '#0f231e'
  surface-container-high: '#192e28'
  surface-container-highest: '#243933'
  on-surface: '#d0e8df'
  on-surface-variant: '#bbcabf'
  inverse-surface: '#d0e8df'
  inverse-on-surface: '#20342f'
  outline: '#86948a'
  outline-variant: '#3c4a42'
  surface-tint: '#4edea3'
  primary: '#4edea3'
  on-primary: '#003824'
  primary-container: '#10b981'
  on-primary-container: '#00422b'
  inverse-primary: '#006c49'
  secondary: '#a8cfbc'
  on-secondary: '#113729'
  secondary-container: '#294e3f'
  on-secondary-container: '#96beab'
  tertiary: '#68dba9'
  on-tertiary: '#003825'
  tertiary-container: '#3eb686'
  on-tertiary-container: '#00422c'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#6ffbbe'
  primary-fixed-dim: '#4edea3'
  on-primary-fixed: '#002113'
  on-primary-fixed-variant: '#005236'
  secondary-fixed: '#c3ecd7'
  secondary-fixed-dim: '#a8cfbc'
  on-secondary-fixed: '#002115'
  on-secondary-fixed-variant: '#294e3f'
  tertiary-fixed: '#85f8c4'
  tertiary-fixed-dim: '#68dba9'
  on-tertiary-fixed: '#002114'
  on-tertiary-fixed-variant: '#005137'
  background: '#031712'
  on-background: '#d0e8df'
  surface-variant: '#243933'
typography:
  headline-xl:
    fontFamily: Hanken Grotesk
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Hanken Grotesk
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  body-lg:
    fontFamily: Manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: JetBrains Mono
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: JetBrains Mono
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.03em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-max: 1280px
  gutter: 24px
  margin-desktop: 64px
  margin-mobile: 20px
---

## Brand & Style

This design system embodies a "High-Contrast Tech-Organic" aesthetic. It merges the precision of modern developer tools with a rich, natural atmosphere. The target audience is high-end professional users who value both focus and luxury.

The design style is a hybrid of **Minimalism** and **Glassmorphism**, utilizing deep depth and translucent layers to create an immersive, focused environment. The UI should feel like a premium physical instrument—substantial, polished, and calm. It avoids "flatness" in favor of tonal layering and subtle 3D cues that suggest a tactile, high-end experience.

## Colors

The palette is anchored in a monochromatic green spectrum to maintain an "earthy energy" while ensuring technical clarity.

- **Primary (#10B981):** A vibrant emerald used for primary actions, success states, and active indicators.
- **Secondary (#D1FAE5):** A soft mint used for high-contrast text, icons against dark backgrounds, and subtle highlights.
- **Background (#0A1F1A):** A deep, ink-like forest green that serves as the foundation, providing more warmth than a standard black or grey.
- **Surface & Surface Bright:** Progressive steps in luminosity used to define hierarchy and elevation without relying on traditional shadows.

## Typography

The typography strategy focuses on "Technical Elegance." 

- **Headlines:** Use **Hanken Grotesk** for its sharp, contemporary geometry. Tight letter-spacing and heavy weights convey authority and premium quality.
- **Body:** Use **Manrope** for its balanced, modern proportions. It provides excellent legibility in long-form text within a dark interface.
- **Functional/Data:** Use **JetBrains Mono** for labels, tags, and metadata. This reinforces the "tech" side of the brand and ensures data-heavy information is easily scannable.

## Layout & Spacing

The design system utilizes a **Fixed Grid** on desktop and a **Fluid Grid** on mobile.

- **Desktop:** 12-column grid with a maximum width of 1280px. Large 64px side margins create a sense of exclusivity and focus.
- **Mobile:** 4-column fluid grid with 20px margins.
- **Rhythm:** All spacing (padding, margins, gaps) must be multiples of 8px. Use generous whitespace between sections to maintain the "Minimalist" aesthetic and allow the deep background colors to "breathe."

## Elevation & Depth

Depth is achieved through **Tonal Layers** and **Glassmorphism**, mimicking a physical stack of semi-translucent glass plates.

1.  **Level 0 (Base):** The deep `#0A1F1A` background.
2.  **Level 1 (Cards/Containers):** `#112B25` with a subtle 1px border of `#1A3D35`. No shadows are used here; the depth is created by the color shift.
3.  **Level 2 (Overlays/Modals):** Glassmorphism style. Background blur (20px) with a semi-transparent surface (`#1A3D35` at 80% opacity). 
4.  **Accents:** Use a soft "inner glow" (top-aligned 1px border in a lighter green) on buttons and active cards to simulate light hitting a physical edge.

## Shapes

The shape language is "Refined Organic." 

Elements use a **Rounded** (0.5rem) base. This softens the technical nature of the typography and colors, making the interface feel more approachable and "earthy." 

- **Standard Buttons/Inputs:** 0.5rem (8px).
- **Cards/Modals:** 1rem (16px).
- **Indicators/Tags:** 1.5rem (24px) for a pill-shaped look.

## Components

- **Buttons:** Primary buttons use a solid `#10B981` fill with white text. Secondary buttons are outlined in `#10B981` with a subtle hover fill. Tertiary buttons use the Mint `#D1FAE5` for text only.
- **Input Fields:** Use the Surface color (`#112B25`) with a 1px border. On focus, the border glows with the primary Emerald color. Labels always use the Monospaced font.
- **Cards:** Cards should not have shadows. Instead, use a subtle gradient from top-left to bottom-right (Surface Bright to Surface) to create a 3D bevel effect.
- **Chips/Badges:** Use JetBrains Mono for text. Backgrounds should be low-opacity versions of the primary color (Emerald) to maintain glass-like transparency.
- **Lists:** Separate items with a thin, low-opacity (`#1A3D35`) horizontal rule. Active list items should feature a 4px vertical "primary emerald" bar on the left edge.
- **Specialty Component - "Status Bloom":** Use a soft, blurred radial gradient behind critical icons or primary buttons to create an "aura" effect, emphasizing the emerald accent color.