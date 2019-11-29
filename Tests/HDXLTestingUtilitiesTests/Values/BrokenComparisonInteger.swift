//
//  BrokenComparisonInteger.swift
//

import Foundation

/// Deliberately-broken `Int`-wrapper:
///
/// - `==` and `!=` is done correctly
/// - all comparison operators just call `<`
///
/// Exists *only* to verify that the coherency tests catch broken types as-expected.
///
struct BrokenComparisonInteger : Equatable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
  
  var value: Int
  
  init(_ value: Int) {
    self.value = value
  }
  
  static func ==(
    lhs: BrokenComparisonInteger,
    rhs: BrokenComparisonInteger) -> Bool {
    return lhs.value == rhs.value
  }

  // see `README.md` for explanation in re `!=`
  
  static func <(
    lhs: BrokenComparisonInteger,
    rhs: BrokenComparisonInteger) -> Bool {
    return lhs.value < rhs.value
  }

  static func <=(
    lhs: BrokenComparisonInteger,
    rhs: BrokenComparisonInteger) -> Bool {
    return lhs.value < rhs.value
  }
  static func >(
    lhs: BrokenComparisonInteger,
    rhs: BrokenComparisonInteger) -> Bool {
    return lhs.value < rhs.value
  }

  static func >=(
    lhs: BrokenComparisonInteger,
    rhs: BrokenComparisonInteger) -> Bool {
    return lhs.value < rhs.value
  }
  
  var description: String {
    get {
      return "broken-comparison \(self.value)"
    }
  }
  
  var debugDescription: String {
    get {
      return "BrokenComparisonInteger(\(self.value))"
    }
  }

}


