//
//  BrokenInteger.swift
//

import Foundation

/// Deliberately-broken `Int`-wrapper:
///
/// - `==` and `!=` both just call `==`
/// - all comparison operators just call `<`
///
/// Exists *only* to verify that the coherency tests catch broken types as-expected.
///
struct BrokenInteger : Equatable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
  
  var value: Int
  
  init(_ value: Int) {
    self.value = value
  }
  
  static func ==(
    lhs: BrokenInteger,
    rhs: BrokenInteger) -> Bool {
    return lhs.value < rhs.value
  }

  // see `README.md` for explanation in re `!=`

  static func <(
    lhs: BrokenInteger,
    rhs: BrokenInteger) -> Bool {
    return lhs.value < rhs.value
  }

  static func <=(
    lhs: BrokenInteger,
    rhs: BrokenInteger) -> Bool {
    return lhs.value < rhs.value
  }
  static func >(
    lhs: BrokenInteger,
    rhs: BrokenInteger) -> Bool {
    return lhs.value < rhs.value
  }

  static func >=(
    lhs: BrokenInteger,
    rhs: BrokenInteger) -> Bool {
    return lhs.value < rhs.value
  }
  
  var description: String {
    get {
      return "broken \(self.value)"
    }
  }
  
  var debugDescription: String {
    get {
      return "BrokenInteger(\(self.value))"
    }
  }

}


