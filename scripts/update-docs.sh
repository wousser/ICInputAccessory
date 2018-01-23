#!/bin/sh

files=(html css js json)

for file in "${files[@]}"
do
  echo "Cleaning whitespace in *.$file..."
  find docs/output -name "*."$file -exec sed -E -i '' -e 's/[[:blank:]]*$//' {} \;
done


cd docs && pwd
git checkout gh-pages
git status
cp -rfv output/* .
git --no-pager diff --stat
git add .
git commit -m "[CI] Update documentation at $(date +'%Y-%m-%d %H:%M:%S %z')"

if [ "${TRAVIS_COMMIT_MESSAGE}" = Merge* ] && [ -n "$DANGER_GITHUB_API_TOKEN" ]; then
  echo "Updating gh-pages..."
  git remote add upstream "https://${DANGER_GITHUB_API_TOKEN}@github.com/polydice/ICInputAccessory.git"
  git push --quiet upstream HEAD:gh-pages
  git remote remove upstream
else
  echo "Skip gh-pages updates on ${TRAVIS_BRANCH}:"
  echo "\n    ${TRAVIS_COMMIT_MESSAGE}\n"
fi

cd -
