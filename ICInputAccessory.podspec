Pod::Spec.new do |s|
  s.name          = "ICInputAccessory"
  s.version       = "1.3.0"
  s.summary       = "A customized token text field used in the iCook app."
  s.description   = <<-DESC
                     ICKeyboardDismissTextField:
                     * An input accessory view with a button to dismiss keyboard.

                     ICTokenField:
                     * A horizontal scrolling UI that groups input texts.
                     * Easy to add, select and delete tokens.
                     * Customizable icon and colors.
                     * Supports storyboard.
                    DESC

  s.screenshots   = "https://polydice.github.io/ICInputAccessory/screenshots/ICTokenField.png",
                    "https://polydice.github.io/ICInputAccessory/screenshots/ICKeyboardDismissTextField.png"
  s.homepage      = "https://github.com/polydice/ICInputAccessory"
  s.license       = { type: "MIT", file: "LICENSE" }
  s.authors       = "bcylin", "trisix"
  s.platform      = :ios, "8.0"
  s.source        = { git: "https://github.com/polydice/ICInputAccessory.git", tag: "v#{s.version}" }
  s.requires_arc  = true

  s.default_subspecs = "KeyboardDismissTextField", "TokenField"

  s.subspec "KeyboardDismissTextField" do |sp|
    sp.source_files  = "Source/KeyboardDismissTextField/*.swift"
    sp.resources     = "Source/KeyboardDismissTextField/*.xcassets"
  end

  s.subspec "TokenField" do |sp|
    sp.source_files  = "Source/TokenField/*.swift"
  end
end
