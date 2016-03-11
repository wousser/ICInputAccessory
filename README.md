# ICInputAccessory

Customized text fields used in the iCook app.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/polydice/ICInputAccessory.svg?branch=develop)](https://travis-ci.org/polydice/ICInputAccessory)

### ICKeyboardDismissTextField

* An input accessory view with a button to dismiss keyboard.

### ICTokenField

* A horizontal scrolling UI that groups input texts.
* Easy to add and delete tokens.
* Customizable icon and colors.

<table>
  <tr>
    <th>ICKeyboardDismissTextField</th>
    <th rowspan="2"></th>
    <th>ICTokenField</th>
  </tr>
  <tr>
    <th><img src="https://raw.githubusercontent.com/polydice/ICInputAccessory/gh-pages/screenshots/ICKeyboardDismissTextField.png" width="90%" /></th>
    <th><img src="https://raw.githubusercontent.com/polydice/ICInputAccessory/gh-pages/screenshots/ICTokenField.png" width="90%" /></th>
  </tr>
</table>

## Installation

### Install via [Carthage](https://github.com/Carthage/Carthage)

* Create a `Cartfile` with the following specification and run `carthage update`.

  ```
  github "polydice/ICInputAccessory"
  ```

* On your application targets' **General** settings tab, in the **Linked Frameworks and Libraries** section, drag and drop `ICInputAccessory.framework` from the Carthage/Build directory.

* On your application targets’ **Build Phases** settings tab, click the **+** icon and choose **New Run Script Phase**. Create a Run Script with the following contents:

  ```
  /usr/local/bin/carthage copy-frameworks
  ```

  and add the following path to **Input Files**:

  ```
  $(SRCROOT)/Carthage/Build/iOS/ICInputAccessory.framework
  ```

* For more information, please check out the [Carthage Documentation](https://github.com/Carthage/Carthage#if-youre-building-for-ios).

## Usage

### ICKeyboardDismissTextField

```swift
let textField = ICKeyboardDismissTextField(frame: rect)
```

### ICTokenField

```swift
let tokenField = ICTokenField(frame: rect)
tokenField.delegate = self as? ICTokenFieldDelegate
```

* The characters that completes a token:

```swift
/// Characters that completes a new token, defaults are whitespace and commas.
public var delimiters: [String]
```

* Tokens:

```swift
/// Texts of each created token.
public var texts: [String] { get }

/// Creates a token with the current input text.
public func completeCurrentInputText()

/// Removes the input text and all displayed tokens.
public func resetTokens()
```

* UI customization:

```swift
/// The image on the left of text field.
public var icon: UIImage? { get set }

/// The placeholder with the default color and font.
public var placeholder: String? { get set }

/// The placeholder with customized attributes.
public var attributedPlaceholder: NSAttributedString? { get set }

/// Customized attributes for tokens in the normal state, e.g. NSFontAttributeName and NSForegroundColorAttributeName.
public var normalTokenAttributes: [String : NSObject]? { get set }

/// Customized attributes for tokens in the highlighted state.
public var highlightedTokenAttributes: [String : NSObject]? { get set }
```

  See `Example/CustomizedTokenField.swift` for more detail.

#### ICTokenFieldDelegate

`ICTokenField` currently notifies its delegate the following events:

* `tokenFieldDidBeginEditing(_:)`
* `tokenFieldDidEndEditing(_:)`
* `tokenFieldWillReturn(_:)`
* `tokenField(_:didEnterText:)`
* `tokenField(_:didDeleteText:atIndex:)`
