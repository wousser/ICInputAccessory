Pod::Spec.new do |s|
  s.name          = "ICInputAccessory"
  s.version       = "1.0.0"
  s.summary       = "Customized text fields used in the iCook app."
  s.description   = <<-DESC
                     ICKeyboardDismissTextField:
                     * An input accessory view with a button to dismiss keyboard.

                     ICTokenField:
                     * A horizontal scrolling UI that groups input texts.
                     * Easy to add and delete tokens.
                     * Customizable icon and colors.
                    DESC

  s.screenshots   = "https://raw.githubusercontent.com/polydice/ICInputAccessory/gh-pages/screenshots/ICKeyboardDismissTextField.png",
                    "https://raw.githubusercontent.com/polydice/ICInputAccessory/gh-pages/screenshots/ICTokenField.png"
  s.homepage      = "https://github.com/polydice/ICInputAccessory"
  s.license       = { type: "MIT", file: "LICENSE" }
  s.authors       = "bcylin", "trisix"

  s.platform      = :ios, "8.0"
  s.source        = { git: "https://github.com/polydice/ICInputAccessory.git", tag: "v#{s.version}" }
  s.source_files  = "Source/*.swift"
  s.resources     = "Source/*.xcassets"
  s.requires_arc  = true
end
