task default: "ci:test"

latest = "10.1"

namespace :ci do
  desc "Build targets on Travis CI with a specified OS version, default OS=#{latest}"
  task :build, [:os] do |t, args|
    version = args[:os] || latest
    Rake::Task["framework:build"].invoke version
    Rake::Task["example:build"].invoke version
  end

  desc "Run tests on Travis CI with a specified OS version, default OS=#{latest}"
  task :test, [:os] do |t, args|
    version = args[:os] || latest
    Rake::Task["framework:build"].invoke version
    # UI Testing requires iOS Simulator 9.0 or later.
    if Gem::Version.new("9.0") <= Gem::Version.new(version)
      Rake::Task["example:test"].invoke version
    else
      Rake::Task["example:build"].invoke version
    end
  end
end


namespace :example do
  desc "Build the example project"
  task :build, [:os] do |t, args|
    version = args[:os] || latest
    sh %(xcodebuild -workspace ICInputAccessory.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 6s,OS=#{version}" clean build | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end

  desc "Run the UI tests in the example project"
  task :test, [:os] do |t, args|
    version = args[:os] || latest
    sh %(xcodebuild -workspace ICInputAccessory.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 6s,OS=#{version}" clean test | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end
end

namespace :framework do
  desc "Build the framework project"
  task :build, [:os] do |t, args|
    version = args[:os] || "latest"
    sh %(xcodebuild -project ICInputAccessory.xcodeproj -scheme ICInputAccessory-iOS -sdk iphonesimulator -destination "name=iPhone 6s,OS=#{version}" clean build | xcpretty -c && exit ${PIPESTATUS[0]})
    exit $?.exitstatus if not $?.success?
  end
end


desc "Bump versions"
task :bump, [:version] do |t, args|
  version = args[:version]
  unless version
    puts %(Usage: rake "bump[version]")
    next
  end

  FileUtils.mv "ICInputAccessory.xcodeproj", "ICInputAccessory.tmp"
  sh %(xcrun agvtool new-marketing-version #{version})
  FileUtils.mv "ICInputAccessory.tmp", "ICInputAccessory.xcodeproj"

  FileUtils.mv "Example.xcodeproj", "Example.tmp"
  sh %(xcrun agvtool new-marketing-version #{version})
  FileUtils.mv "Example.tmp", "Example.xcodeproj"

  podspec = "ICInputAccessory.podspec"
  text = File.read podspec
  File.write podspec, text.gsub(%r(\"\d+\.\d+\.\d+\"), "\"#{version}\"")
  puts "Updated #{podspec} to #{version}"

  jazzy = ".jazzy.yml"
  text = File.read jazzy
  File.write jazzy, text.gsub(%r(:\s\d+\.\d+\.\d+), ": #{version}")
  puts "Updated #{jazzy} to #{version}"

  sh %(bundle exec pod install)
end
