bootstrap:
	gem install bundler
	bundle install
	bundle exec pod install

install: bundle-install pod-install

bundle-install:
	bundle install --without development --deployment --jobs=3 --retry=3

pod-install:
	bundle exec pod install

bump:
ifeq (,$(strip $(version)))
	# Usage: make bump version=<number>
else
	ruby -pi -e "gsub(/\d+\.\d+\.\d+/i, \""$(version)"\")" ICInputAccessory.podspec
	ruby -pi -e "gsub(/:\s\d+\.\d+\.\d+/i, \": "$(version)"\")" .jazzy.yml
	xcrun agvtool new-marketing-version $(version)
endif

carthage:
	set -o pipefail && carthage build --no-skip-current --verbose | bundle exec xcpretty

docs:
	test -d docs || git clone -b gh-pages --single-branch https://github.com/polydice/ICInputAccessory.git docs
	cd docs && git fetch origin gh-pages && git clean -f -d
	cd docs && git checkout gh-pages && git reset --hard origin/gh-pages
	bundle exec jazzy --config .jazzy.yml
