//
//  ElementAssertions.swift
//

import Foundation
import XCTest

// -------------------------------------------------------------------------- //
// MARK: Distinct-Element Assertions
// -------------------------------------------------------------------------- //

/// Asserts that all elements in the collection  `c` are pairwise-distinct (e.g. `!=`).
///
/// - parameter c: A collection of elements.
///
/// - seealso: `HDXLConfirmPairwiseDistinctElements(_:)`
///
@inlinable
public func HDXLAssertPairwiseDistinctElements<C:Collection>(_ c: C)
  where C.Element: Equatable {
    // a little clunky, but *should* generally be more-efficient than, e.g.,
    // doing nested double-iteration in `c.enumerated()` with a `where bIndex < aIndex`:
    for aIndex in c.indices {
      let a = c[aIndex]
      for b in c[c.startIndex..<aIndex] {
        XCTAssertNotEqual(
          a,
          b,
          "Expected pairwise-distinct contents, but found repeated element \(a) in \(c)!"
        )
      }
    }
}

/// Asserts that all elements in the collection  `c` are pairwise-distinct (e.g. `!=`).
///
/// - parameter c: A collection of elements.
///
/// - seealso: `HDXLConfirmPairwiseDistinctElements(_:)`
///
/// - note: Faster equivalent to `HDXLAssertPairwiseDistinctElements` when elements are hashable.
/// - todo: Decide if I should expose this under a different name.
///
@inlinable
public func HDXLAssertPairwiseDistinctElements<C:Collection>(_ c: C)
  where C.Element: Hashable {
    // a little clunky, but *should* generally be more-efficient than, e.g.,
    // doing nested double-iteration in `c.enumerated()` with a `where bIndex < aIndex`:
    XCTAssertEqual(
      c.count,
      Set(c).count,
      "Expected pairwise-distinct elements in \(String(reflecting: c))!"
    )
}

/// Work-alike for `HDXLAssertPairwiseDistinctElements` that returns `true` iff
/// all elements in the collection `c` are pairwise-distinct.
///
/// - parameter c: A collection of elements.
///
/// - returns: `true` iff there are no repeated elements in `c`.
///
/// - seealso: `HDXLAssertPairwiseDistinctElements(_:)`
///
@inlinable
public func HDXLConfirmPairwiseDistinctElements<C:Collection>(_ c: C) -> Bool
  where C.Element: Equatable {
    // a little clunky, but *should* generally be more-efficient than, e.g.,
    // doing nested double-iteration in `c.enumerated()` with a `where bIndex < aIndex`:
    for aIndex in c.indices {
      let a = c[aIndex]
      for b in c[c.startIndex..<aIndex] {
        guard a != b else {
          return false
        }
      }
    }
    return true
}

/// Work-alike for `HDXLAssertPairwiseDistinctElements` that returns `true` iff
/// all elements in the collection `c` are pairwise-distinct.
///
/// - parameter c: A collection of elements.
///
/// - returns: `true` iff there are no repeated elements in `c`.
///
/// - seealso: `HDXLAssertPairwiseDistinctElements(_:)`
///
/// - note: Faster equivalent to `HDXLConfirmPairwiseDistinctElements` for hashable elements.
/// - todo: Decide if I should expose this under a different name.
///
@inlinable
public func HDXLConfirmPairwiseDistinctElements<C:Collection>(_ c: C) -> Bool
  where C.Element: Hashable {
    // a little clunky, but *should* generally be more-efficient than, e.g.,
    // doing nested double-iteration in `c.enumerated()` with a `where bIndex < aIndex`:
    return c.count == Set(c).count
}

// -------------------------------------------------------------------------- //
// MARK: Disjointness Assertions
// -------------------------------------------------------------------------- //

/// Utility to assert that two collections are disjoint (e.g. no common elements).
///
/// - parameter a: A collection of elements
/// - parameter b: A collection of elements
///
/// - note: Made this a standalone function b/c I split this out from `HDXLCommonUtilities`.
///
/// - seealso: `HDXLAssertDisjointCollections(_:_:)`
///
@inlinable
public func HDXLAssertDisjointCollections<A:Collection,B:Collection>(_ a: A, _ b: B)
  where A.Element == B.Element, A.Element: Equatable {
    for aa in a {
      for bb in b {
        XCTAssertNotEqual(
          aa,
          bb,
          "Found common element \(aa) in supposedly-distinct `a` (\(a)) and `b` (\(b))!")
      }
    }
}

/// Utility to assert that two collections are disjoint (e.g. no common elements).
///
/// - parameter a: A collection of elements
/// - parameter b: A collection of elements
///
/// - note: Made this a standalone function b/c I split this out from `HDXLCommonUtilities`.
///
/// - seealso: `HDXLAssertDisjointCollections(_:_:)`
///
@inlinable
public func HDXLAssertDisjointCollections<A:Collection,B:Collection>(_ a: A, _ b: B)
  where A.Element == B.Element, A.Element: Hashable {
    XCTAssertTrue(
      Set(a).isDisjoint(with: b),
      "Expected disjoint collections here for `a` \(String(reflecting: a)) and `b` \(String(reflecting: a))."
    )
}

/// Work-alike for `HDXLAssertPairwiseDistinct` that just reports whether or not
/// the provided collections were actually distinct.
///
/// - parameter a: A collection of elements
/// - parameter b: A collection of elements
///
/// - returns: `true` iff `a` and `b` have no elements in common.
///
/// - seealso: `HDXLAssertDisjointCollections(_:_:)`
///
@inlinable
public func HDXLConfirmDisjointCollections<A:Collection,B:Collection>(_ a: A, _ b: B) -> Bool
  where A.Element == B.Element, A.Element: Equatable {
    for aa in a {
      for bb in b {
        guard aa != bb else {
          return false
        }
      }
    }
    return true
}

/// Work-alike for `HDXLAssertPairwiseDistinct` that just reports whether or not
/// the provided collections were actually distinct.
///
/// - parameter a: A collection of elements
/// - parameter b: A collection of elements
///
/// - returns: `true` iff `a` and `b` have no elements in common.
///
/// - seealso: `HDXLAssertDisjointCollections(_:_:)`
///
@inlinable
public func HDXLConfirmDisjointCollections<A:Collection,B:Collection>(_ a: A, _ b: B) -> Bool
  where A.Element == B.Element, A.Element: Hashable {
    // could come back and set-ify the smaller one
    return Set(a).isDisjoint(with: b)
}
