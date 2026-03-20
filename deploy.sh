#!/bin/bash

set -euo pipefail

projectdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$projectdir"

current_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ $current_branch != "heads/master" ]]; then
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
oude_versie="$(git tag --list 'v*' --sort=v:refname | tail -n1)"
echo "De vorige versie is $oude_versie. Versieverhoging? (major|minor|patch|premajor|preminor|prepatch|prerelease) "
read -r versie_type
if [[ $versie_type == pre* ]]; then
    echo "Release? (alpha|beta|rc)"
    read -r preid
else
    preid=""
fi
npm version --preid "$preid" "$versie_type"

# package maken
if [[ $preid == "" ]]; then
    npm publish
else
    npm publish --tag "$preid"
fi

git gc
git push origin
