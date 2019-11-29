//
//  EqualityTestingSupport.swift
//

import Foundation
import XCTest

/// Utility to verify that `==` and `!=` are coherent (e.g. satisfy all expected
/// invariants).
///
/// For `values` a collection wherein each element *should be* distinct (e.g. `!=`),
/// exhaustively tries all pairs--in all orderings--and confirms that `==` and `!=`
/// have correct, *consistent* semantics.
///
/// In other words, for `a` and `b` in `values`, we expect the following:
///
/// 1. `a == b` iff `a` and `b` are at the same position
/// 2. `a != b` iff `a` and `b` are at different positions
/// 3. `(a == b) == (a == b)`
///
/// Because `!=` is *not* a protocol extension point, however, we don't need to
/// test that `a == b <=> !(a != b)`--or, better-put, we can't test it *generically*.
///
/// What I mean is you can still supply a `!=` for your type, it'll get called
/// in non-generic contexts, and you can still thus have inconsistency between
/// `==` and `!=`...but that `!=` won't get called in a generic context, and thus
/// also won't show up in this generic test method, either.
///
/// So all we can really test here is that supposedly-equal things are equal--and
/// that supposedly non-equal things are non-equal--and that `==` is properly symmetric.
///
/// - parameter values: A collection wherein all values should be pairwise-distinct (e.g. pairwise `!=`).
///
/// - seealso: `HDXLConfirmCoherentEquality(forDistinctValues:)`
/// - note: Like all generic code, this can unfortunately be *rather slow* in `Debug` builds; c'est la vie.
///
@inlinable
public func HDXLAssertCoherentEquality<C:Collection>(forDistinctValues values: C)
  where C.Element:Equatable {
    for (lIndex,lValue) in values.enumerated() {
      for (rIndex,rValue) in values.enumerated() where rIndex <= lIndex {
        XCTAssertEqual(
          (lIndex == rIndex),
          (lValue == rValue),
          "Found incoherent ==, \(lValue) == \(rValue) *should* => \(lIndex == rIndex), but *instead* => \(lValue == rValue)!"
        )
        XCTAssertEqual(
          (lIndex != rIndex),
          (lValue != rValue),
          "Found incoherent !=, \(lValue) != \(rValue) *should* => \(lIndex != rIndex), but *instead* => \(lValue != rValue)!"
        )
        XCTAssertEqual(
          (lValue == rValue),
          (rValue == lValue),
          "Found asymmetric `==`, ((\(lValue) == `\(rValue)) == (\(rValue) == \(lValue)) *should* be true, but instead (\(lValue) == \(rValue)) => \(lValue == rValue) and (\(rValue) == \(lValue)) => \(rValue == lValue)!"
        )
      }
    }
}

/// Work-alike for `HDXLAssertCoherentEquality`, except rather than call any of
/// the `XCTAssert` functions it just reports "success/failure" as `true`/`false`.
///
/// - parameter values: A collection wherein all values should be pairwise-distinct (e.g. pairwise `!=`).
///
/// - returns: `true` iff `values` is actually distinct *and* no inconsistencies in `==` and `!=` were discovered.
/// 
/// - seealso: `HDXLAssertCoherentEquality(forDistinctValues:)`
/// - todo: Add support for customizable logging in case I want to use this and still see details.
///
@inlinable
public func HDXLConfirmCoherentEquality<C:Collection>(forDistinctValues values: C) -> Bool
  where C.Element: Equatable {
    // see corresponding comment in `HDXLAssertCoherentEquality`.
    for (lIndex,lValue) in values.enumerated() {
      for (rIndex,rValue) in values.enumerated() where rIndex <= lIndex {
        guard
          (lIndex == rIndex) == (lValue == rValue),
          (lIndex != rIndex) == (lValue != rValue),
          (lValue == rValue) == (rValue == lValue) else {
            return false
        }
      }
    }
    return true
}
