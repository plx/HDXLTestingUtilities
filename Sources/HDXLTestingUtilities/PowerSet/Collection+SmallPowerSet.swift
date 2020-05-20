//
//  Collection+SmallPowerSet.swift
//

import Foundation

public extension Collection {
  
  /// Utility to pull out a powerset from a base collection of count
  /// *no more than* **`8`**...do your own slicing if necessary.
  ///
  /// This is a bit wastefully-implemented. If it's unusably-wasteful I'll fix it now,
  /// otherwise I'll wait until `some` supports `where` clauses and then make this
  /// a lazy map from `0...iterationBound -> [Element]` (or similar).
  @inlinable
  func smallPowerSet() -> [[Element]] {
    precondition((0...8).contains(self.count))
    var result: [[Element]] = []
    let iterationUpperBound = UInt8(powerSetIterationUpperBoundForSourceCount: self.count)
    result.reserveCapacity(Int(iterationUpperBound))
    for bitset in 0...iterationUpperBound {
      var subset: [Element] = []
      bitset.forEachSetBit() {
        subset.append(
          self[
            self.index(
              self.startIndex,
              offsetBy: $0
            )
          ]
        )
      }
    }
    return result
  }
    
}

internal extension UInt8 {
  
  @inlinable
  init(powerSetIterationUpperBoundForSourceCount count: Int) {
    precondition((0...8).contains(count))
    self = 0
    for shift in 0..<count {
      self |= 1 << shift
    }
  }
  
  @inlinable
  func forEachSetBit(do work: (Int) throws -> Void) rethrows {
    // probably a cleaner way to get that early-exit:
    var clone = self
    for shift in 0..<8 {
      if (clone & 1) != 0 {
        try work(shift)
      }
      clone = clone >> 1
      if clone == 0 {
        return
      }
    }
  }
  
}
