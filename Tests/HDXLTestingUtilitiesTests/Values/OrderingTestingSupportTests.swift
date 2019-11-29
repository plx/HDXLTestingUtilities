//
//  OrderingTestingSupportTests.swift
//

import Foundation
import XCTest
@testable import HDXLTestingUtilities

class OrderingTestingSupportTests: XCTestCase {
  
  let testCounts: [Int] = [
    2,
    10,
    100
  ]
  
  func testOrderingCoherenceTestsAgainstUniformArray() {
    self.haltingOnFirstError {
      for count in self.testCounts {
        // we need distinct values in our array or else our test should fail
        let integers = [Int](
          repeating: count,
          count: count
        )
        
        // since our reference is invalid everything should fail:
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenInteger($0)
            }
          )
        )
      }
    }
  }
  
  func testOrderingCoherenceTestsAgainstAscendingArray() {
    self.haltingOnFirstError {
      for count in self.testCounts {
        let integers = 0..<count
        // reference is coherent:
        XCTAssertTrue(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers
          )
        )
        // b/c ordering involves `==` *and* `<`, etc., none
        // of the broken types should pass this test:
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenInteger($0)
            }
          )
        )
      }
    }
  }

  func testOrderingCoherenceTestsAgainstDescendingArray() {
    self.haltingOnFirstError {
      for count in self.testCounts {
        let integers = (0..<count).reversed()
        // our reference needs to be ascending, ergo everything should fail:
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentOrdering(
            forAscendingDistinctValues: integers.map() {
              BrokenInteger($0)
            }
          )
        )
      }
    }
  }

}


