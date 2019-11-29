//
//  OrderingTestingSupport.swift
//

import Foundation
import XCTest

/// Utility to verify that `<`, etc., satisfy all expected invariants.
///
/// For `values` a collection of *distinct* values in *ascending* order, will compare
/// all pairs--in all orders--and confirm the following:
///
/// 1. `values` actually does contain distinct values (as per `==` and `!=`)
/// 2. `values` actually is ordered-ascending (as per `<`)
/// 3. `==`, `!=` , `<`, `<=`, `>`, `>=` exhibit *consistent* semantics
///
/// Note that (3) is the real test, here--it's trivial *if* `==` and `!=` have
/// been correctly-implemented--whereas (1) and (2) are *more* for confirmation
/// that `values` has been constructed correctly.
///
/// - parameter values: A collection wherein all values should be distinct and ordered-ascending
///
/// - seealso: `HDXLConfirmCoherentOrdering(forAscendingDistinctValues:)`
/// - note: Like all generic code, this can unfortunately be *rather slow* in `Debug` builds; c'est la vie.
///
@inlinable
public func HDXLAssertCoherentOrdering<C:Collection>(forAscendingDistinctValues values: C)
  where C.Element: Comparable {
    // we not only want to compare *all pairs* but *all pairs in all orders*.
    // In other words, for each `a` and `b`, we want to compare `a` and `b` as
    // well as `b` and `a`. I could cut the iteration *count* in half by switching
    // to `where rIndex <= lIndex`, but if I did that I'd have to double the number
    // of assertions within the loop body. In this case readability and maintainability
    // favors having fewer assertions and "redundant" iteration--scare quotes b/c
    // in this case we're ultimately doing *almost* exactly the same work either way.
    for (lIndex,lValue) in values.enumerated() {
      for (rIndex,rValue) in values.enumerated() {
        // equality verification:
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

        // expected-ordering verification:
        XCTAssertEqual(
          (lValue == rValue),
          !(lValue != rValue),
          "Found incoherent ==, != pair: `lValue == rValue` == `lValue != rValue` == \(lValue == rValue), which should never happen!"
        )
        XCTAssertEqual(
          (lIndex < rIndex),
          (lValue < rValue),
          "Found incoherent <, \(lValue) < \(rValue) *should* => \(lIndex < rIndex), but *instead* => \(lValue < rValue)!"
        )
        XCTAssertEqual(
          (lIndex <= rIndex),
          (lValue <= rValue),
          "Found incoherent <=, \(lValue) <= \(rValue) *should* => \(lIndex <= rIndex), but *instead* => \(lValue <= rValue)!"
        )
        XCTAssertEqual(
          (lIndex > rIndex),
          (lValue > rValue),
          "Found incoherent >, \(lValue) > \(rValue) *should* => \(lIndex > rIndex), but *instead* => \(lValue >= rValue)!"
        )
        XCTAssertEqual(
          (lIndex >= rIndex),
          (lValue >= rValue),
          "Found incoherent >=, \(lValue) >= \(rValue) *should* => \(lIndex >= rIndex), but *instead* => \(lValue >= rValue)!"
        )
        
        // ordering-coherency verification;
        // these are all arguably redundant vis-a-vis the above,
        // but why not verify explicitly while we're at it?
        XCTAssertEqual(
          (lValue < rValue),
          !(lValue >= rValue),
          "Found incoherency for < and >=: `lValue < rValue <=> !(lValue >= rValue)`, but got `lValue < rValue` => \(lValue < rValue) and `lValue >= lValue` => \(rValue >= lValue)!"
        )
        XCTAssertEqual(
          (lValue <= rValue),
          !(lValue > rValue),
          "Found incoherency for <= and >: `lValue <= rValue <=> !(lValue > rValue)`, but got `lValue <= rValue` => \(lValue <= rValue) and `lValue > lValue` => \(rValue > lValue)!"
        )
        XCTAssertEqual(
          (lValue > rValue),
          !(lValue <= rValue),
          "Found incoherency for > and <=: `lValue > rValue <=> !(lValue <= rValue)`, but got `lValue > rValue` => \(lValue > rValue) and `lValue <= lValue` => \(rValue <= lValue)!"
        )
        XCTAssertEqual(
          (lValue >= rValue),
          !(lValue < rValue),
          "Found incoherency for >= and <: `lValue >= rValue <=> !(lValue < rValue)`, but got `lValue >= rValue` => \(lValue >= rValue) and `lValue < lValue` => \(rValue < lValue)!"
        )
      }
    }
}

/// Work-alike for `HDXLAssertCoherentOrdering`, except rather than call any of
/// the `XCTAssert` functions it just reports "success/failure" as `true`/`false`.
///
/// - parameter values: A collection of distinct values in ascending order.
///
/// - returns: `true` iff both (a) the elements in `values` *are* distinct-and-ordered-ascending and also (b) no inconsistencies were discovered between `==`, `!=`, `<`, `<=`, `>`, and `>=`.
///
/// - seealso: `HDXLAssertCoherentOrdering(forAscendingDistinctValues:)`
/// - todo: Add support for customizable logging in case I want to use this and still see details.
///
@inlinable
public func HDXLConfirmCoherentOrdering<C:Collection>(forAscendingDistinctValues values: C) -> Bool
  where C.Element: Comparable {
    for (lIndex,lValue) in values.enumerated() {
      for (rIndex,rValue) in values.enumerated() {
        guard
          // distinctness-verification:
          (lIndex == rIndex) == (lValue == rValue),
          (lIndex != rIndex) == (lValue != rValue),
          // ordering-verification:
          (lIndex < rIndex) == (lValue < rValue),
          (lIndex <= rIndex) == (lValue <= rValue),
          (lIndex > rIndex) == (lValue > rValue),
          (lIndex >= rIndex) == (lValue >= rValue),
          // ordering-coherence:
          (lValue < rValue) == !(lValue >= rValue),
          (lValue <= rValue) == !(lValue > rValue),
          (lValue > rValue) == !(lValue <= rValue),
          (lValue >= rValue) == !(lValue < rValue) else {
            return false
        }
      }
    }
    return true
}
