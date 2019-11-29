//
//  PairwiseDistinctTests.swift
//

import Foundation
import XCTest
@testable import HDXLTestingUtilities

class PairwiseDistinctTests: XCTestCase {
  
  let testCounts: [Int] = [
    2,
    10,
    100
  ]
  
  func testRangePairwiseDistinctness() {
    self.haltingOnFirstError {
      for count in self.testCounts {
        let k = 0..<count
        XCTAssertTrue(
          HDXLConfirmPairwiseDistinctElements(k)
        )
        HDXLAssertPairwiseDistinctElements(k)
        XCTAssertFalse(
          HDXLConfirmPairwiseDistinctElements(
            k.map({ $0/2})
          )
        )
      }
    }
  }
  
}

