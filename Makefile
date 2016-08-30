install: brew-install bundle-install pod-install

brew-install:
	brew update
	brew tap homebrew/bundle
	brew bundle

bundle-install:
	bundle install --without development --deployment --jobs=3 --retry=3

pod-install:
	bundle exec pod install --no-repo-update

setup: brew-install
	bundle install
	bundle exec pod install --no-repo-update

carthage:
	set -o pipefail && carthage build --no-skip-current --verbose | xcpretty

documentation:
	bundle exec jazzy --config .jazzy.yml
