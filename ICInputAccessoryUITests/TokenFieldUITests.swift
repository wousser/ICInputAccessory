//
//  TokenFieldUITests.swift
//  ICInputAccessoryUITests
//
//  Created by Ben on 08/03/2016.
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

import XCTest

class TokenFieldUITests: XCTestCase {

  private lazy var app = XCUIApplication()

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app.launch()
  }

  private func typeTexts(in textField: XCUIElement) {
    textField.tap()
    textField.typeText("Try")
    textField.typeText(" ")
    textField.typeText("iCook")
    textField.typeText(",")
    textField.typeText("beta")
    textField.typeText(" ")

    let deleteKey = app.keys["delete"]
    deleteKey.tap()
    deleteKey.tap()

    textField.typeText("TestFlight")
    textField.typeText(",")

    app.buttons["Search"].tap()
  }

  func testTokenField() {
    let textField = app.tables.cells.containing(.staticText, identifier: "TokenField").children(matching: .textField).element
    typeTexts(in: textField)
  }

  func testCustomizedTokenField() {
    app.tables.staticTexts["CustomizedTokenField"].tap()
    let tokenField = app.navigationBars["Example.CustomizedTokenView"].scrollViews.children(matching: .textField).element
    typeTexts(in: tokenField)
  }

  func testStoryboard() {
    app.tables.buttons["Storyboard"].tap()
    let tokenField = app.tables.cells.containing(.staticText, identifier: "Storyboard TokenField").children(matching: .textField).element
    typeTexts(in: tokenField)
    app.tables.buttons["Back to Code"].tap()
  }

}
