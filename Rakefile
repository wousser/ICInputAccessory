task default: "ci:test"

namespace :ci do
  desc "Build targets on Travis CI with a specified OS version, default OS=latest"
  task :build, [:os] do |t, args|
    Rake::Task["build"].execute os: args[:os], scheme: "ICInputAccessory-iOS"
    Rake::Task["build"].execute os: args[:os], scheme: "Example"
  end

  desc "Run tests on Travis CI with a specified OS version, default OS=latest"
  task :test, [:os] do |t, args|
    # UI Testing requires iOS Simulator 9.0 or later.
    action = !args[:os] || Gem::Version.new("9.0") <= Gem::Version.new(args[:os]) ? "test" : "build"
    Rake::Task[action].execute os: args[:os], scheme: "Example"
  end
end


def xcodebuild(params)
  [
    %(xcodebuild),
    %(-workspace ICInputAccessory.xcworkspace),
    %(-scheme #{params[:scheme]}),
    %(-sdk iphonesimulator),
    %(-destination 'name=iPhone 7,OS=#{params[:version] || "latest"}'),
    %(#{params[:action]} | xcpretty -c && exit ${PIPESTATUS[0]})
  ].join " "
end


desc "Build the target with the specified scheme"
task :build, [:os, :scheme] do |t, args|
  sh xcodebuild(scheme: args[:scheme], version: args[:os], action: "clean build")
  exit $?.exitstatus if not $?.success?
end


desc "Run the UI tests in the example project"
task :test, [:os] do |t, args|
  sh xcodebuild(scheme: "Example", version: args[:os], action: "clean test")
  exit $?.exitstatus if not $?.success?
end
