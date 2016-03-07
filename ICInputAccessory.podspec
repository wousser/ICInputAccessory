Pod::Spec.new do |s|
  s.name          = "ICInputAccessory"
  s.version       = "0.1.0"
  s.summary       = "A customized input accessory UI to dismiss keyboard."

  s.homepage      = "https://github.com/polydice/ICInputAccessory"
  s.license       = { type: "MIT", file: "LICENSE" }
  s.authors       = "bcylin", "trisix"

  s.platform      = :ios, "8.0"
  s.source        = { git: "https://github.com/polydice/ICInputAccessory.git", tag: "v#{s.version}" }
  s.source_files  = "Source/*.swift"
  s.resources     = "Source/*.xcassets"
  s.requires_arc  = true
end
