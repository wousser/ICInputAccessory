//
//  ICKeyboardDismissTextField.swift
//  ICInputAccessory
//
//  Created by Ben on 07/03/2016.
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

public class ICKeyboardDismissTextField: UITextField {

  private lazy var accessoryView: UIView = {
    let _accessory = ICKeyboardDismissAccessoryView()
    _accessory.dismissButton.addTarget(self, action: Selector("dismiss:"), forControlEvents: .TouchUpInside)
    return _accessory
  }()

  // MARK: - Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setUpAccessoryView()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpAccessoryView()
  }

  // MARK: - UIResponder

  public override func becomeFirstResponder() -> Bool {
    if UI_USER_INTERFACE_IDIOM() == .Phone {
      accessoryView.alpha = 1
    }
    return super.becomeFirstResponder()
  }

  // MARK: - Private Methods

  private func setUpAccessoryView() {
    if UI_USER_INTERFACE_IDIOM() == .Phone {
      inputAccessoryView = accessoryView
    }
  }

  @IBAction private func dismiss(sender: UIButton) {
    resignFirstResponder()
    UIView.animateWithDuration(0.3) {
      self.accessoryView.alpha = 0
    }
  }

}
