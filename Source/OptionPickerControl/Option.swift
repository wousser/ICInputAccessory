//
//  Option.swift
//  ICInputAccessory
//
//  Created by Ben on 22/11/2017.
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

import Foundation

/// The protocol defines the required variables to be displayed in a `UIPickerView` via `OptionPickerControl`.
public protocol OptionDescriptive: Equatable {
  /// The text for the row in the `UIPickerView`.
  var title: String { get }
  /// The text for a placeholder row when the picker selection is optional.
  static var titleForOptionalValue: String { get }
}


/// An option struct that carries the `OptionDescriptive`
public struct Option<T: OptionDescriptive>: Equatable {

  // MARK: - Initialization

  /// Returns an option that displays the optional value of an `OptionDescriptive` type.
  public static func optional() -> Option<T> {
    return Option<T>()
  }

  /// Returns an initialized option with an instance of an `OptionDescriptive` type.
  public init(_ value: T) {
    self.value = value
  }

  // MARK: - Properties

  /// Conformance to `OptionDescriptive`.
  public var title: String {
    return value?.title ?? T.titleForOptionalValue
  }

  /// The `OptionDescriptive` value of the option. Returns `nil` when it's the `optional` placeholder.
  public let value: T?

  // MARK: - Private

  private init() {
    self.value = nil
  }

  // MARK: - Equatable

  /// Returns true when two options' values are equal.
  public static func == (lhs: Option<T>, rhs: Option<T>) -> Bool {
    return lhs.value == rhs.value
  }

}
