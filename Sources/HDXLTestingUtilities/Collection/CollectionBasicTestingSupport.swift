//
//  CollectionBasicTestingSupport.swift
//

import Foundation
import XCTest

public extension Collection {
  
  /// Obtain the count by iterating from start-to-finish.
  ///
  /// - note: Motivated by collections with (a) complex iteration logic but (b) easily-calculable counts; easy to get the right calculation but wrong iteration!
  @inlinable
  func countByIterating() -> Int {
    var count = 0
    for _ in self {
      count += 1
    }
    return count
  }
  
}

/// Function testing certain basic invariants of `Collection` (like `isEmpty <=> count == 0`, etc..).
///
/// *Not* very comprehensive, but nevertheless useful as a first-pass sanity check.
///
/// - seealso: `HDXLAssertCollectionIndexSanity(_:)`
///
@inlinable
public func HDXLAssertCollectionBasicSanity<C:Collection>(_ collection: C) {
  
  // non-negative count:
  XCTAssertTrue(
    collection.count >= 0,
    "`collection.count >= 0` should always be true, but got `collection.count` => \(collection.count)!"
  )
  
  XCTAssertEqual(
    collection.isEmpty,
    collection.count == 0,
    "`collection.isEmpty` <=> `collection.count == 0`, but got `collection.isEmpty` => \(collection.isEmpty) and `collection.count` => \(collection.count)!"
  )

  XCTAssertEqual(
    collection.isEmpty,
    collection.startIndex == collection.endIndex,
    "`collection.isEmpty` <=> `collection.startIndex == collection.endIndex`, but `collection.isEmpty` => \(collection.isEmpty), but for `collection.startIndex` == \(collection.startIndex), `collection.endIndex` == \(collection.endIndex) we got `collection.startIndex == collection.endIndex` == \(collection.startIndex == collection.endIndex)!"
  )

  XCTAssertEqual(
    collection.count,
    collection.distance(
      from: collection.startIndex,
      to: collection.endIndex
    ),
    "`collection.count == collection.distance(from: collection.startIndex, to: collection.endIndex)`, but `collection.count` => \(collection.count) and `collection.distance(from: collection.startIndex, to: collection.endIndex)` => \(collection.distance(from: collection.startIndex, to: collection.endIndex))!"
  )

  // first == nil <=> isEmpty
  XCTAssertEqual(
    collection.first == nil,
    collection.isEmpty,
    "`collection.first == nil` <=> `collection.isEmpty`, but `collection.first` => \(String(describing: collection.first)) and `collection.isEmpty` => \(collection.isEmpty)!"
  )

  // count matches manual count:
  XCTAssertEqual(
    collection.count,
    collection.countByIterating(),
    "`collection.count == collection.countByIterating()`, but `collection.count` => \(collection.count) and `collection.countByIterating()` => \(collection.countByIterating())!"
  )

}

