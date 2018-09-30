//
//  OptionPickerControl.swift
//  ICInputAccessory
//
//  Created by Ben on 27/11/2017.
//  Copyright © 2017 bcylin.
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

/// A `UIControl` that displays a `UIPickerView` and notifies changed selection and via `UIControlEvents` `.valueChanged`.
open class OptionPickerControl<T: OptionDescriptive>: UIControl, UIPickerViewDataSource, UIPickerViewDelegate {

  // MARK: - Initialization

  /// Returns an initialized `OptionPickerControl`.
  public init() {
    super.init(frame: .zero)
    addSubview(hiddenTextField)
  }

  /// Not supported. `OptionPickerControl` is not compatible with storyboards.
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported")
  }

  // MARK: - Properties

  /// Options that shows in the `UIPickerView`.
  public var options: [Option<T>] = [Option<T>.optional()]

  /// The currently selected item in the options.
  public var selectedOption: Option<T> = Option<T>.optional() {
    didSet {
      if hiddenTextField.isFirstResponder {
        sendActions(for: .valueChanged)
      } else if let index = options.index(of: selectedOption) {
        picker.selectRow(index, inComponent: 0, animated: false)
      }
    }
  }

  /// A reference to the displayed `UIPickerView` for customization.
  public private(set) lazy var picker: UIPickerView = {
    let picker = UIPickerView()
    picker.dataSource = self
    picker.delegate = self
    return picker
  }()

  // MARK: - Lazy Instantiation

  private lazy var doneBarButton: UIBarButtonItem =
    UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPicker(_:)))

  private lazy var pickerToolbar: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    toolbar.items = [
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      self.doneBarButton
    ]
    return toolbar
  }()

  private lazy var hiddenTextField: UITextField = {
    let textField = UITextField()
    textField.inputAccessoryView = self.pickerToolbar
    textField.inputView = self.picker
    return textField
  }()

  // MARK: - UIResponder

  @discardableResult
  override open func becomeFirstResponder() -> Bool {
    return super.becomeFirstResponder() || hiddenTextField.becomeFirstResponder()
  }

  @discardableResult
  override open func resignFirstResponder() -> Bool {
    return hiddenTextField.resignFirstResponder()
  }

  // MARK: - UIPickerViewDataSource

  /// Currently `OptionPickerControl` only supports one component.
  open func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return options.count
  }

  // MARK: - UIPickerViewDelegate

  open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return options[row].title
  }

  open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedOption = options[row]
  }

  // MARK: - IBActions

  @objc private func dismissPicker(_ sender: Any) {
    resignFirstResponder()
  }

}
