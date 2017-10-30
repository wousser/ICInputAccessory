bootstrap:
	gem install bundler
	bundle install
	bundle exec pod install

install: bundle-install pod-install

bundle-install:
	bundle install --without development --deployment --jobs=3 --retry=3

pod-install:
	bundle exec pod install

carthage:
	set -o pipefail && carthage build --no-skip-current --verbose | bundle exec xcpretty

docs:
	rm -rfv docs
	git clone -b gh-pages --single-branch https://github.com/polydice/ICInputAccessory.git docs
	bundle exec jazzy --config .jazzy.yml
