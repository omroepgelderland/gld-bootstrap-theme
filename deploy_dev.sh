#!/bin/bash

function delete_dist_bestanden() {
    rm -rf dist
}

set -euo pipefail

projectdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$projectdir"

# Node environment
if [ ! -f "$HOME/.nvm/nvm.sh" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi
export NODE_ENV=development
# shellcheck disable=SC1091
. "$HOME/.nvm/nvm.sh"
nvm install node
npm install npm@latest -g

# npm packages
npm install
npm audit fix

# generate dist
delete_dist_bestanden
npx sass \
    --pkg-importer=node \
    --style=expanded \
    --quiet-deps \
    src/scss/theme.scss \
    dist/theme.css
npx sass \
    --pkg-importer=node \
    --no-source-map \
    --style=compressed \
    --quiet-deps \
    src/scss/theme.scss \
    dist/theme.min.css
git ls-files -z | grep -zP '\.(ts|js|css|scss|html|json)$' | xargs -0 npx prettier --write
