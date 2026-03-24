# @omroepgelderland/bootstrap-theme

Bootstrap 5 theme voor de 2026 Omroep Gelderland huisstijl.

Dit pakket bevat een customized Bootstrap build met:

- GLD huisstijl kleuren
- Poppins lettertype (via [fontsource](https://www.npmjs.com/package/@fontsource/poppins))

## Installatie

```bash
npm install @omroepgelderland/bootstrap-theme bootstrap
```

## Gebruik

### Gebruik compiled CSS

```js
import "@omroepgelderland/bootstrap-theme";
```

Of expliciet:

```js
import "@omroepgelderland/bootstrap-theme/css";
```

### Gebruik SCSS

Als je SASS gebruikt in je project:

```scss
@use "@omroepgelderland/bootstrap-theme";
```

Of expliciet:

```scss
@use "@omroepgelderland/bootstrap-theme/scss";
```

### Gebruik compiled CSS in SCSS

```scss
@use "@omroepgelderland/bootstrap-theme/css";
```

### Gebruik SCSS tokens

GLD tokens en de standaard Bootstrap tokens worden geëxporteerd zodat je ze in je project kunt hergebruiken:

```scss
@use "@omroepgelderland/bootstrap-theme";
@use "@omroepgelderland/bootstrap-theme/bootstrap" as bs;
@use "@omroepgelderland/bootstrap-theme/tokens" as gld;

.example {
  color: bs.$success;
  background: gld.$kleur-corporate1;
}
```

#### Webpack

Gebruik de volgende opties in sass-loader.

Dit is alleen nodig als je SCSS importeert. Als je alleen de compiled CSS gebruikt is dit niet nodig.

```ts
import * as sass from "sass";

const config: webpack.Configuration = {
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [
          {
            loader: "sass-loader",
            options: {
              implementation: sass,
              sassOptions: {
                importers: [new sass.NodePackageImporter()],
              },
            },
          },
        ],
      },
    ],
  },
};
```

## Ontwikkeling

### Build CSS

```bash
./deploy_dev.sh
```

### Pakket publiceren

```bash
./deploy.sh
```
