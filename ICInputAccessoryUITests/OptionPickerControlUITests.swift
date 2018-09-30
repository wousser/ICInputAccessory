//
//  OptionPickerControlUITests.swift
//  ICInputAccessoryUITests
//
//  Created by Ben on 21/01/2018.
//  Copyright © 2018 bcylin.
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

import XCTest

final class OptionPickerControlUITests: XCTestCase {

  private lazy var app = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }

  func testOptionSelection() {
    app.tables.staticTexts["(Optional)"].tap()
    let picker = app.pickerWheels.element

    picker.adjust(toPickerWheelValue: "English")
    XCTAssert(app.tables.staticTexts["English"].exists)

    picker.adjust(toPickerWheelValue: "French")
    XCTAssert(app.tables.staticTexts["French"].exists)

    picker.adjust(toPickerWheelValue: "German")
    XCTAssert(app.tables.staticTexts["German"].exists)

    picker.adjust(toPickerWheelValue: "Japanese")
    XCTAssert(app.tables.staticTexts["Japanese"].exists)

    picker.adjust(toPickerWheelValue: "Mandarin")
    XCTAssert(app.tables.staticTexts["Mandarin"].exists)

    picker.adjust(toPickerWheelValue: "Spanish")
    XCTAssert(app.tables.staticTexts["Spanish"].exists)

    app.toolbars.buttons["Done"].tap()
  }

}
