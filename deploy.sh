#!/bin/bash

set -euo pipefail

projectdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$projectdir"

current_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ $current_branch != "master" ]]; then
    echo "Op branch $current_branch ipv master. Toch doorgaan? (j/n)"
    read -r ans
    if [[ $ans != "j" ]]; then
        exit 1
    fi
fi

./deploy_dev.sh

if [ -n "$(git status --untracked-files=no --porcelain)" ]; then
    git status
    echo "Er zijn uncommitted changes. Toch doorgaan? (j/n)"
    read -r ans
    if [[ $ans != "j" ]]; then
        exit 1
    fi
fi

# nvm environment
# shellcheck disable=SC1091
. "$HOME/.nvm/nvm.sh"
nvm install node

# versieverhoging
oude_versie="$(npm pkg get version | tr -d '"')"
preid=""
if [[ -z $oude_versie ]]; then
    npm version "0.1.0"
else
    echo "De vorige versie is $oude_versie. Versieverhoging? (major|minor|patch|premajor|preminor|prepatch|prerelease) "
    read -r versie_type
    if [[ $versie_type == pre* ]]; then
        echo "Release? (alpha|beta|rc)"
        read -r preid
        npm version --preid "$preid" "$versie_type"
    else
        npm version "$versie_type"
    fi
fi
nieuwe_versie="$(npm pkg get version | tr -d '"')"
git_versie="v$nieuwe_versie"

# package maken
if [[ -z $preid ]]; then
    npm publish
else
    npm publish --tag "$preid"
fi

git tag "$git_versie"
git gc
git push origin
git push origin "$git_versie"
