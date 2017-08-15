platform :ios, "8.0"
use_frameworks!

workspace "ICInputAccessory"
project "ICInputAccessory"
project "Example"

target "Example" do
  pod "ICInputAccessory/KeyboardDismissTextField", path: "./"
  pod "ICInputAccessory/TokenField", path: "./"
  pod "SwiftLint", "0.19.0"
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["SWIFT_VERSION"] = "3.0"
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
  end
end
