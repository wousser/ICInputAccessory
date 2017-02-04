## v1.4.0

* Added delegate methods:

  ```swift
@objc optional func tokenField(_ tokenField: ICTokenField, didChangeInputText text: String)
@objc optional func tokenField(_ tokenField: ICTokenField, shouldCompleteText text: String) -> Bool
```

* Changed delegate method:

  ```swift
@objc optional func tokenField(_ tokenField: ICTokenField, didCompleteText text: String)
```

## v1.3.0

* Swift 3.0
* Support `pod try ICInputAccessory`

## v1.2.1

* Update to Xcode 8.2

## v1.2.0

* Swift 2.3

## v1.1.0

* Swift 2.2
* Support storyboard
* Support subspecs

## v1.0.0

Initial release written in Swift 2.1.

* `ICKeyboardDismissTextField` with an accessory view to dismiss keyboard.
* `ICTokenField`, a text field that groups input texts as tokens.
