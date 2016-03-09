//
//  CustomizedTokenField.swift
//  Example
//
//  Created by Ben on 09/03/2016.
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
import ICInputAccessory

class CustomizedTokenField: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpSubviews()
  }

  private func setUpSubviews() {
    backgroundColor = UIColor(red:0.96, green:0.48, blue:0.4, alpha:1)

    let tokenField = ICTokenField()
    tokenField.applyCustomizedStyle()
    tokenField.translatesAutoresizingMaskIntoConstraints = false
    addSubview(tokenField)

    let views = ["field": tokenField]
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[field]-10-|", options: [], metrics: nil, views: views))
    addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-3-[field]-3-|", options: [], metrics: nil, views: views))
  }

}


////////////////////////////////////////////////////////////////////////////////


extension ICTokenField {

  func applyCustomizedStyle() {
    layer.cornerRadius = 5
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.mainScreen().scale
    backgroundColor = UIColor(red:0.8, green:0.32, blue:0.24, alpha:1)

    textField.textColor = UIColor.whiteColor()
    textField.tintColor = UIColor.whiteColor()
    textField.font = UIFont.boldSystemFontOfSize(14)

    attributedPlaceholder = NSAttributedString(
      string: String(self.dynamicType),
      attributes: [
        NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.5),
        NSFontAttributeName: UIFont.boldSystemFontOfSize(14)
      ]
    )

    normalTokenAttributes = [
      NSForegroundColorAttributeName: UIColor.whiteColor(),
      NSBackgroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.25),
      NSFontAttributeName: UIFont.boldSystemFontOfSize(14)
    ]

    highlightedTokenAttributes = [
      NSForegroundColorAttributeName: UIColor(red:0.8, green:0.32, blue:0.24, alpha:1),
      NSBackgroundColorAttributeName: UIColor.whiteColor(),
      NSFontAttributeName: UIFont.boldSystemFontOfSize(14)
    ]
  }

}
