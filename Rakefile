task default: :build

desc "Build the framework target and the example project"
task :build, [:os] do |t, args|
  version = args[:os] || "latest"
  sh %(xcodebuild -project ICInputAccessory.xcodeproj -scheme ICInputAccessory-iOS -sdk iphonesimulator -destination "name=iPhone 5,OS=#{version}" clean build | xcpretty -c)
  sh %(xcodebuild -workspace ICInputAccessory.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 5,OS=#{version}" clean build | xcpretty -c)
end

desc "Run the UI tests in the example project"
task :test do |t, args|
  sh %(xcodebuild -workspace ICInputAccessory.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" clean test | xcpretty -c)
end
