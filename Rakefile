task default: "ci:test"

namespace :ci do
  desc "Run tests on Travis CI with a specified OS version, default OS=latest"
  task :test, [:os] do |t, args|
    version = args[:os] || "latest"
    Rake::Task["framework:build"].invoke version
    Rake::Task["example:test"].invoke version
  end
end

namespace :example do
  desc "Build the example project"
  task :build, [:os] do |t, args|
    version = args[:os] || "latest"
    sh %(xcodebuild -workspace ICInputAccessory.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 5,OS=#{version}" clean build | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end

  desc "Run the UI tests in the example project"
  task :test, [:os] do |t, args|
    version = args[:os] || "latest"
    sh %(xcodebuild -workspace ICInputAccessory.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 6,OS=#{version}" clean test | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end
end

namespace :framework do
  desc "Build the framework project"
  task :build, [:os] do |t, args|
    version = args[:os] || "latest"
    sh %(xcodebuild -project ICInputAccessory.xcodeproj -scheme ICInputAccessory-iOS -sdk iphonesimulator -destination "name=iPhone 5,OS=#{version}" clean build | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end
end
