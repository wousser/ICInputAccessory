//
//  ExampleViewController.swift
//  Example
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
import ICInputAccessory

class ExampleViewController: UIViewController, UITableViewDataSource {

  private(set) lazy var tableView: UITableView = {
    let _tableView = UITableView(frame: .zero, style: .Grouped)
    _tableView.registerClass(ExampleCell.self, forCellReuseIdentifier: NSStringFromClass(ExampleCell.self))
    _tableView.allowsSelection = false
    _tableView.dataSource = self
    return _tableView
  }()

  private let types: [UIView.Type] = [ICKeyboardDismissTextField.self]

  // MARK: - Initialization

  convenience init() {
    self.init(nibName: nil, bundle: nil)
    title = "ICInputAccessory"
  }

  // MARK: - UIViewController

  override func loadView() {
    super.loadView()
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    let _ = ICTokenField()
  }

  // MARK: - UITableViewDataSource

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return types.count
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch types[section] {
    case is ICKeyboardDismissTextField.Type:
      return "Dismiss Keyboard"
    default:
      return ""
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ExampleCell.self), forIndexPath: indexPath)
    switch types[indexPath.section] {
    case let type as ICKeyboardDismissTextField.Type:
      let textField = type.init()
      textField.leftViewMode = .Always
      textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
      textField.placeholder = String(type)
      (cell as? ExampleCell)?.showcase = textField
    default:
      break
    }
    return cell
  }

}
