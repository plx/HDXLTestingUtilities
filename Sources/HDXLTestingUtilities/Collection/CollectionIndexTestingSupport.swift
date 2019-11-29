//
//  CollectionIndexTestingSupport.swift
//

import Foundation
import XCTest

/// Exhaustively verifies that `collection`'s indices and the collection, itself,
/// have consistent semantics vis-a-vis (a) the collection's index-distance/movement
/// logic and (b) the indices' own `==` and `<` implementations.
///
/// This exists because the ordering-and-comparison logic winds up duplicated
/// between collections and their indices: on the one hand, `Collection.Index`
/// must be `Comparable` and thus has its own `==` and `<`, etc., implementations;
/// on the other hand, `Collection`-API methods like `distance(from:to:)`, `index(after:)`,
/// and so on provide another set of implicit equality-and-ordering relationships.
///
/// Both of those relationships must be consistent: if `Index` thinks `a < b`,
/// then e.g. `distance(from: a, to: b)` must be `> 0` *and* some number of iterated
/// calls of `index(after:)` must send `a` to `b`.
///
/// Similarly, if `distance(from: a, to: b)` is `d >= 0`, then it must also be
/// true that both (1) `d` iterations of `index(after:)` sends `a` to `b` and, further,
/// (2) `index(a, offsetBy: d) == b`.
///
/// We can generally rely upon this all working out; where we can't, however, is
/// in scenarios in which both (1) our indices have complicated internal structure
/// and also (b) the implementations of things like `index(after:)` and `index(_:offsetBy:)`
/// have different-looking structure. Bugs resulting from such inconsistencies can be
/// subtle and hard to discover without exhaustive testing...or at least that was my
/// experience implementing various `itertools`-inspired `Collection`-combinators.
///
/// - parameter collection: Any arbitrary collection.
///
/// - warning: Extremely slow just b/c it's generic and usually runs in `Debug`; it's also *at least* O(n^2) and maybe O(n^3) or even O(n^4). *Strongly* suggest calling on the smallest-possible collections that will adequately-test your index type.
///
/// - note: No `Confirm`-equivalent supplied b/c, IMHO, if you want this at all you *need* to know what went wrong.
///
@inlinable
public func HDXLAssertCollectionIndexSanity<C:Collection>(_ collection: C) {
  
  // validate start/end ordering is consistent:
  XCTAssertLessThanOrEqual(
    collection.startIndex,
    collection.endIndex,
    "`collection.startIndex` should be <= `collection.endIndex`, but \(String(reflecting: collection.startIndex)) isn't <= \(String(reflecting: collection.endIndex))"
  )

  // validate emptiness
  XCTAssertEqual(
    collection.isEmpty,
    collection.indices.isEmpty,
    "`collection.isEmpty` (\(collection.isEmpty)) should equal `collection.indices.isEmpty` \(collection.indices.isEmpty))!"
  )

  // validate count sanity
  XCTAssertEqual(
    collection.count,
    collection.indices.count,
    "`collection.count` (\(collection.count)) should equal `collection.indices.count` \(collection.indices.count))!"
  )
  
  // basic sanity-check on collection indices:
  HDXLAssertCoherentOrdering(
    forAscendingDistinctValues: collection.indices
  )
  
  // TODO: chain2 to tack on the `endIndex` and run again

  // validate `collection.indices` contains only *subscriptable* indices:
  for (lLocation,lIndex) in collection.indices.enumerated() {
    XCTAssertGreaterThanOrEqual(
      lIndex,
      collection.startIndex,
      "`collection.indices` should only contain *subscriptable* indices, but \(String(reflecting: collection)).indices (\(String(reflecting: collection.indices))) contained non-subscriptable index \(String(reflecting: lIndex))!"
    )
    XCTAssertLessThan(
      lIndex,
      collection.endIndex,
      "`collection.indices` should only contain *subscriptable* indices, but \(String(reflecting: collection)).indices (\(String(reflecting: collection.indices))) contained non-subscriptable index \(String(reflecting: lIndex))!"
    )
    let distanceFromStart = collection.distance(
      from: collection.startIndex,
      to: lIndex
    )
    let indexAtDistance = collection.index(
      collection.startIndex,
      offsetBy: distanceFromStart
    )
    XCTAssertEqual(
      lIndex,
      indexAtDistance,
      "Failed to round-trip index \(String(reflecting: lIndex)) via distance-from-start \(distanceFromStart); arrived at \(indexAtDistance)!"
    )

    let next = collection.index(after: lIndex)
    XCTAssertEqual(
      collection.distance(
        from: lIndex,
        to: next
      ),
      1,
      "`collection.index(after:)` should advance by one, but went from \(String(reflecting: lIndex)) to \(String(reflecting: next)) w/ distance \(collection.distance(from: lIndex, to: next))"
    )
    for (_rLocation,rIndex) in collection.indices[next..<collection.endIndex].enumerated() {
      let rLocation = lLocation + _rLocation + 1
      XCTAssertEqual(
        collection.distance(
          from: lIndex,
          to: rIndex
        ),
        -collection.distance(
          from: rIndex,
          to: lIndex
        ),
        "Index-distance symmetry violation \(String(reflecting: lIndex)) and \(String(reflecting: rIndex))!"
      )
      XCTAssertEqual(
        rLocation - lLocation,
        collection.distance(
          from: lIndex,
          to: rIndex
        ),
        "Found distance-mismatch between \(String(reflecting: lIndex)) and \(String(reflecting: rIndex)): should-be \(rLocation - lLocation) but got \(collection.distance(from: lIndex, to: rIndex))!"
      )
    }

  }
  
}
