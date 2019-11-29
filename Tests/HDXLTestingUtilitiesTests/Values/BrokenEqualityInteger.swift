//
//  BrokenEqualityInteger.swift
//

import Foundation

/// Deliberately-broken `Int`-wrapper:
///
/// - `==` and `!=` both call `==`
/// - all comparison operators are correct
///
/// Exists *only* to verify that the coherency tests catch broken types as-expected.
///
struct BrokenEqualityInteger : Equatable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
  
  var value: Int
  
  init(_ value: Int) {
    self.value = value
  }
  
  static func ==(
    lhs: BrokenEqualityInteger,
    rhs: BrokenEqualityInteger) -> Bool {
    return lhs.value < rhs.value
  }
  
  // see `README.md` for explanation in re `!=`

  static func <(
    lhs: BrokenEqualityInteger,
    rhs: BrokenEqualityInteger) -> Bool {
    return lhs.value < rhs.value
  }

  static func <=(
    lhs: BrokenEqualityInteger,
    rhs: BrokenEqualityInteger) -> Bool {
    return lhs.value <= rhs.value
  }
  static func >(
    lhs: BrokenEqualityInteger,
    rhs: BrokenEqualityInteger) -> Bool {
    return lhs.value > rhs.value
  }

  static func >=(
    lhs: BrokenEqualityInteger,
    rhs: BrokenEqualityInteger) -> Bool {
    return lhs.value >= rhs.value
  }
  
  var description: String {
    get {
      return "broken-equality \(self.value)"
    }
  }
  
  var debugDescription: String {
    get {
      return "BrokenEqualityInteger(\(self.value))"
    }
  }

}


