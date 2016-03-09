//
//  ICTokenField.swift
//  iCook
//
//  Created by Ben on 01/03/2016.
//  Copyright © 2016 Polydice, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

public protocol ICTokenFieldDelegate: class {
  func tokenFieldDidBeginEditing(tokenField: ICTokenField)
  func tokenFieldDidEndEditing(tokenField: ICTokenField)
  func tokenFieldWillReturn(tokenField: ICTokenField)
  func tokenField(tokenField: ICTokenField, didEnterText text: String)
}

////////////////////////////////////////////////////////////////////////////////


public class ICTokenField: UIView, UITextFieldDelegate, ICBackspaceTextFieldDelegate {

  public weak var delegate: ICTokenFieldDelegate?

  /// Characters that completes a new token, defaults are whitespace and commas.
  public var delimiters = [" ", ",", "，"]

  /// Texts of each created token.
  public var texts: [String] {
    return tokens.map { $0.text }
  }

  /// The image on the left of text field.
  public var icon: UIImage? {
    didSet {
      if let icon = icon {
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .Center
        leftView = imageView
      } else {
        leftView = nil
      }
    }
  }

  /// The text field that handles text inputs.
  /// Do not change textField's delegate, which is required to be handled by ICTokenField.
  public var textField: UITextField {
    return inputTextField
  }

  /// The placeholder with the default color and font.
  public var placeholder: String? {
    get {
      return attributedPlaceholder?.string
    }
    set {
      if let text = newValue {
        attributedPlaceholder = NSAttributedString(
          string: text,
          attributes: [NSForegroundColorAttributeName: UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 0.9)]
        )
      } else {
        attributedPlaceholder = nil
      }
    }
  }

  // MARK: - UI Customization

  /// The placeholder with customized attributes.
  public var attributedPlaceholder: NSAttributedString? {
    didSet {
      guard let attributedText = attributedPlaceholder else {
        placeholderLabel.text = nil
        return
      }
      placeholderLabel.attributedText = attributedText

      if placeholderLabel.superview != nil { return }
      insertSubview(placeholderLabel, belowSubview: scrollView)
      placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
      placeholderLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow - 1, forAxis: .Horizontal)
      addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .Leading, relatedBy: .Equal, toItem: scrollView, attribute: .Leading, multiplier: 1, constant: 0))
      addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .Trailing, relatedBy: .GreaterThanOrEqual, toItem: scrollView, attribute: .Trailing, multiplier: 1, constant: 10))
      addConstraint(NSLayoutConstraint(item: placeholderLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    }
  }

  /// Customized attributes for tokens in the normal state, e.g. NSFontAttributeName and NSForegroundColorAttributeName.
  public var normalTokenAttributes: [String: NSObject]? {
    didSet {
      tokens.forEach { $0.normalTextAttributes = normalTokenAttributes ?? [:] }
    }
  }

  /// Customized attributes for tokens in the highlighted state.
  public var highlightedTokenAttributes: [String: NSObject]? {
    didSet {
      tokens.forEach { $0.highlightedTextAttributes = normalTokenAttributes ?? [:] }
    }
  }

  // MARK: - Private Properties

  private var tokens = [ICToken]()

  private lazy var inputTextField: ICBackspaceTextField = {
    let _textField = ICBackspaceTextField()
    _textField.backgroundColor = UIColor.clearColor()
    _textField.clearButtonMode = .WhileEditing
    _textField.autocorrectionType = .No
    _textField.returnKeyType = .Search
    _textField.delegate = self
    _textField.backspaceDelegate = self
    _textField.addTarget(self, action: Selector("togglePlaceholderIfNeeded:"), forControlEvents: .AllEditingEvents)
    return _textField
  }()

  private var leftView: UIView? {
    didSet {
      oldValue?.removeFromSuperview()
      if let icon = leftView {
        addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[icon]-10-[wrapper]", options: [], metrics: nil, views: ["icon": icon, "wrapper": scrollView]))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        leftEdgeConstraint.active = false
      } else {
        leftEdgeConstraint.active = true
      }
    }
  }

  private let placeholderLabel = UILabel()

  private lazy var scrollView: UIScrollView = {
    let _scrollView = UIScrollView()
    _scrollView.clipsToBounds = true
    _scrollView.directionalLockEnabled = true
    _scrollView.showsHorizontalScrollIndicator = false
    _scrollView.showsVerticalScrollIndicator = false
    _scrollView.backgroundColor = UIColor.clearColor()
    return _scrollView
  }()

  private lazy var leftEdgeConstraint: NSLayoutConstraint = {
    NSLayoutConstraint(item: self.scrollView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 10)
  }()

  private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
    UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
  }()

  // MARK: - Initialization

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpSubviews()
  }

  // MARK: - UIResponder

  override public func isFirstResponder() -> Bool {
    return inputTextField.isFirstResponder() || super.isFirstResponder()
  }

  override public func becomeFirstResponder() -> Bool {
    return inputTextField.becomeFirstResponder()
  }

  override public func resignFirstResponder() -> Bool {
    super.resignFirstResponder()
    return inputTextField.resignFirstResponder()
  }

  // MARK: - UIView

  override public func layoutSubviews() {
    super.layoutSubviews()
    layoutTokenTextField()
  }

  // MARK: - UITextFieldDelegate

  public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    tokens.forEach { $0.highlighted = false }
    return true
  }

  public func textFieldDidBeginEditing(textField: UITextField) {
    delegate?.tokenFieldDidBeginEditing(self)
  }

  public func textFieldDidEndEditing(textField: UITextField) {
    completeCurrentInputText()
    togglePlaceholderIfNeeded()
    tokens.forEach { $0.highlighted = false }
    delegate?.tokenFieldDidEndEditing(self)
  }

  public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    removeHighlightedToken()  // as user starts typing when a token is focused
    inputTextField.showsCursor = true

    guard
      let input = textField.text,
      let text: NSString = (input as NSString).stringByReplacingCharactersInRange(range, withString: string)
    else {
      return true
    }

    for delimiter in delimiters as [NSString] {
      let index = text.length - delimiter.length
      if 0 < index && text.substringFromIndex(index) == delimiter {
        let newToken = text.substringToIndex(index)
        textField.text = nil

        if newToken != delimiter {
          tokens.append(ICToken(text: newToken, normalAttributes: normalTokenAttributes, highlightedAttributes: highlightedTokenAttributes))
          layoutTokenTextField()
          delegate?.tokenField(self, didEnterText: newToken)
        }
        togglePlaceholderIfNeeded()

        return false
      }
    }
    return true
  }

  public func textFieldShouldReturn(textField: UITextField) -> Bool {
    completeCurrentInputText()
    togglePlaceholderIfNeeded()
    delegate?.tokenFieldWillReturn(self)
    return true
  }

  // MARK: - ICBackspaceTextFieldDelegate

  func textFieldShouldDelete(textField: ICBackspaceTextField) -> Bool {
    if tokens.isEmpty {
      return true
    }

    if !textField.showsCursor {
      removeHighlightedToken()
      return true
    }

    if let text = textField.text where text.isEmpty {
      textField.showsCursor = false
      tokens.last?.highlighted = true
    }
    return true
  }

  // MARK: - UIResponder Callbacks

  @IBAction private func togglePlaceholderIfNeeded(sender: UITextField? = nil) {
    let showsPlaceholder = tokens.isEmpty && (inputTextField.text?.isEmpty ?? true)
    placeholderLabel.hidden = !showsPlaceholder
  }

  @IBAction private func handleTapGesture(sender: UITapGestureRecognizer) {
    if !isFirstResponder() {
      inputTextField.becomeFirstResponder()
    }

    let touch = sender.locationInView(scrollView)
    var shouldFocusInputTextField = true

    // Hilight the tapped token
    for token in tokens {
      if token.frame.contains(touch) {
        scrollView.scrollRectToVisible(token.frame, animated: true)
        token.highlighted = true
        shouldFocusInputTextField = false
      } else {
        token.highlighted = false
      }
    }

    inputTextField.showsCursor = shouldFocusInputTextField
  }

  // MARK: - Private Methods

  /**
  Returns true if any highlighted token is found and removed, otherwise false.
  */
  private func removeHighlightedToken() -> Bool {
    for (index, token) in tokens.enumerate() {
      if token.highlighted {
        tokens.removeAtIndex(index)
        layoutTokenTextField()
        togglePlaceholderIfNeeded()
        inputTextField.showsCursor = true
        return true
      }
    }
    return false
  }

  private func setUpSubviews() {
    if CGRectEqualToRect(frame, CGRect.zero) {
      frame = CGRect(x: 0, y: 7, width: UIScreen.mainScreen().bounds.width, height: 30)
    }

    backgroundColor = UIColor.whiteColor()

    addSubview(scrollView)
    scrollView.addSubview(inputTextField)
    scrollView.translatesAutoresizingMaskIntoConstraints = false

    let views = ["wrapper": scrollView]
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=10)-[wrapper]|", options: [], metrics: nil, views: views))
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[wrapper]|", options: [], metrics: nil, views: views))
    leftEdgeConstraint.active = true

    layoutTokenTextField()
    addGestureRecognizer(tapGestureRecognizer)
  }

  private func layoutTokenTextField() {
    var offset = CGFloat(0)
    var contentRect = CGRect.zero

    scrollView.subviews.filter { $0 is ICToken } .forEach { $0.removeFromSuperview() }

    for token in tokens {
      let frame = CGRect(
        x: offset,
        y: (scrollView.frame.height - token.frame.height) / 2,
        width: token.frame.width,
        height: token.frame.height
      )
      token.frame = frame
      offset += token.frame.width
      contentRect = contentRect.union(token.frame)

      scrollView.addSubview(token)
    }

    inputTextField.frame = CGRect(
      x: offset,
      y: 0,
      width: max(scrollView.frame.width / 3, scrollView.frame.width - offset),
      height: scrollView.frame.height
    )

    contentRect = contentRect.union(inputTextField.frame)
    scrollView.contentSize = contentRect.size
    scrollView.scrollRectToVisible(inputTextField.frame, animated: true)
  }

  // MARK: - Public Methods

  /// Creates a token with the current input text.
  public func completeCurrentInputText() {
    guard let text = inputTextField.text where !text.isEmpty else {
      return
    }
    inputTextField.text = nil
    tokens.append(ICToken(text: text, normalAttributes: normalTokenAttributes, highlightedAttributes: highlightedTokenAttributes))
    layoutTokenTextField()
    delegate?.tokenField(self, didEnterText: text)
  }

  /// Removes the input text and all displayed tokens.
  public func resetTokens() {
    inputTextField.text = nil
    tokens.removeAll()
    layoutTokenTextField()
    togglePlaceholderIfNeeded()
  }

}
