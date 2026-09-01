---
name: Lavender Ethereal
colors:
  surface: '#fbf8ff'
  surface-dim: '#dbd9e2'
  surface-bright: '#fbf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f5f2fc'
  surface-container: '#efecf6'
  surface-container-high: '#e9e7f1'
  surface-container-highest: '#e4e1eb'
  on-surface: '#1b1b22'
  on-surface-variant: '#484554'
  inverse-surface: '#303037'
  inverse-on-surface: '#f2eff9'
  outline: '#797586'
  outline-variant: '#c9c4d7'
  surface-tint: '#6042d6'
  primary: '#451ebb'
  on-primary: '#ffffff'
  primary-container: '#5d3fd3'
  on-primary-container: '#d8ceff'
  inverse-primary: '#cabeff'
  secondary: '#715574'
  on-secondary: '#ffffff'
  secondary-container: '#fbd7fc'
  on-secondary-container: '#775b7a'
  tertiary: '#464060'
  on-tertiary: '#ffffff'
  tertiary-container: '#5d5779'
  on-tertiary-container: '#d8cff7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e6deff'
  primary-fixed-dim: '#cabeff'
  on-primary-fixed: '#1c0062'
  on-primary-fixed-variant: '#4723be'
  secondary-fixed: '#fbd7fc'
  secondary-fixed-dim: '#debcdf'
  on-secondary-fixed: '#29132d'
  on-secondary-fixed-variant: '#583e5b'
  tertiary-fixed: '#e6deff'
  tertiary-fixed-dim: '#cac1e8'
  on-tertiary-fixed: '#1c1735'
  on-tertiary-fixed-variant: '#484263'
  background: '#fbf8ff'
  on-background: '#1b1b22'
  surface-variant: '#e4e1eb'
typography:
  headline-xl:
    fontFamily: Manrope
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Work Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Work Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Work Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Work Sans
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
  headline-lg-mobile:
    fontFamily: Manrope
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
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
  margin-mobile: 16px
  margin-desktop: 40px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
---

## Brand & Style
This design system centers on a "Soft Lavender" aesthetic, moving away from sterile grays to a palette that feels warm, calm, and intellectually inviting. The target audience values clarity and a sense of "digital wellness."

The style is **Minimalist with a Tactile twist**. It utilizes heavy whitespace to create an airy feel, but replaces the traditional cold white with a subtle lilac glow. The emotional response is one of serenity and focus, making it ideal for productivity tools, wellness apps, or refined social platforms. High-contrast deep plum accents ensure that despite the soft backdrop, the interface remains accessible and authoritative.

## Colors
The color strategy is built on a "Tinted Neutral" foundation. 
- **Base Background:** #F8F5FF is used globally instead of white to eliminate screen glare and establish the lavender theme.
- **Primary:** An Indigo (#5D3FD3) serves as the main interactive color for links and primary actions.
- **Deep Plum:** Used for typography (#301934) to provide maximum legibility against the lavender background while feeling more sophisticated than pure black.
- **Surface Tints:** Use #E0D7FF for secondary button backgrounds or inactive states to maintain the monochromatic harmony.

## Typography
The typography balances the modern, refined structure of **Manrope** for headlines with the grounded, reliable legibility of **Work Sans** for body text. 

Headlines should use the Deep Plum color to anchor the page. For body text, use slightly reduced opacity or the "text_muted" token for secondary information to maintain the airy hierarchy. Ensure all uppercase labels have slight letter-spacing to improve scanability.

## Layout & Spacing
This design system employs a **Fluid Grid** with generous inner padding to reinforce the "airy" brand pillar.

- **Desktop:** 12-column grid with 24px gutters. Use wide margins (40px+) to keep content centered and breathable.
- **Mobile:** 4-column grid with 16px margins. 
- **Rhythm:** All spacing follows an 8px base unit. Vertical stack spacing should be aggressive—err on the side of more whitespace to prevent the tinted background from feeling heavy.

## Elevation & Depth
Depth is created through **Tonal Layers** and **Ambient Shadows** rather than stark borders.

1.  **Level 0 (Base):** The #F8F5FF lavender tint.
2.  **Level 1 (Cards/Surfaces):** Pure white (#FFFFFF) is used as an elevation layer. This makes cards appear to "pop" off the lavender background.
3.  **Shadows:** Use extremely soft, diffused shadows with a tiny hint of the primary color. (e.g., `box-shadow: 0 10px 30px rgba(93, 63, 211, 0.08)`).
4.  **Interactive:** On hover, elements should slightly lift (move -2px Y-axis) and the shadow should become slightly more pronounced.

## Shapes
Shapes are distinctly **Rounded** (0.5rem base) to complement the "welcoming" brand personality. 

- **Buttons & Inputs:** Use the standard 0.5rem (8px) radius.
- **Large Cards:** Use `rounded-xl` (1.5rem / 24px) to create a soft, container-like feel.
- **Chips/Badges:** Use "Pill-shaped" (999px) to differentiate them from interactive buttons.

## Components
- **Buttons:** Primary buttons use the Indigo background with white text. Secondary buttons use a semi-transparent Deep Plum stroke (1px) or a light lavender fill (#E0D7FF).
- **Input Fields:** Use a white background to contrast against the lavender page. Focus states should use a 2px Indigo border and a soft Indigo outer glow.
- **Cards:** Always white background, 24px padding, and 24px corner radius. No border is necessary; use the ambient shadow for definition.
- **Chips:** Small, pill-shaped elements with a slightly darker lavender fill (#EBE4FF) and Deep Plum text for high contrast.
- **Lists:** Use subtle Indigo dots or icons. Dividers should be 1px solid #E0D7FF (low contrast) to keep the layout clean.
- **Navigation:** A persistent top bar with a glassmorphism effect (backdrop-blur: 10px; background: rgba(248, 245, 255, 0.8)) helps maintain context while scrolling.