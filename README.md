# @omroepgelderland/bootstrap-theme

Bootstrap 5 theme for the 2026 Omroep Gelderland branding.

This package provides a customized Bootstrap build with:

- GLD brand colors and tokens
- Poppins as the default font (via `@fontsource`)

## Installation

```bash
npm install @omroepgelderland/bootstrap-theme bootstrap
```

## Usage

### Use prebuilt CSS (recommended)

```js
import "@omroepgelderland/bootstrap-theme";
```

### Use SCSS (advanced)

If your project uses Sass:

```scss
@use "@omroepgelderland/bootstrap-theme";
```

### Use design tokens

You can reuse the tokens in your own SCSS:

```scss
@use "@omroepgelderland/bootstrap-theme";          // CSS output
@use "@omroepgelderland/bootstrap-theme/bootstrap" as bs;
@use "@omroepgelderland/bootstrap-theme/tokens" as gld;

.example {
  color: bs.$success;
  background: gld.$kleur-corporate1;
}
```

## Development

### Build CSS

```bash
./deploy_dev.sh
```

### Publish new package

```bash
./deploy.sh
```
