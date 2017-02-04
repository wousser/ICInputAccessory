#!/bin/sh

if ! command -v swiftlint >/dev/null; then
  brew install swiftlint
elif [ ! -e .swiftlint-version ] || [ $(swiftlint version) != $(head -n 1 .swiftlint-version) ]; then
  brew upgrade swiftlint
  swiftlint version >> .swiftlint-version
fi

swiftlint
