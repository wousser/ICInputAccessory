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
	make -B docs
endif

carthage:
	set -o pipefail && carthage build --no-skip-current --verbose | bundle exec xcpretty

docs:
	bundle exec jazzy --config .jazzy.yml
	for file in "html" "css" "js" "json"; do \
		echo "Trimming whitespace in *."$$file ; \
		find docs -name "*."$$file -exec sed -E -i "" -e "s/[[:blank:]]*$$//" {} \; ; \
	done
