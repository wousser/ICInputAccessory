task default: :build

desc "Build the framework target and the example project"
task :build do
  sh %(xcodebuild -project ICInputAccessory.xcodeproj -scheme ICInputAccessory-iOS -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" clean build | xcpretty -c)
  sh %(xcodebuild -workspace ICInputAccessory.xcworkspace -scheme Example -sdk iphonesimulator -destination "name=iPhone 6,OS=latest" clean build | xcpretty -c)
end
