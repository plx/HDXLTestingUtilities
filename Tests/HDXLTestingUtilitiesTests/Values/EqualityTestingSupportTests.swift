//
//  EqualityTestingSupportTests.swift
//

import Foundation
import XCTest
@testable import HDXLTestingUtilities

class EqualityTestingSupportTests: XCTestCase {
  
  let testCounts: [Int] = [
    2,
    10,
    100
  ]
  
  func testEqualityCoherenceTestsAgainstUniformArray() {
    self.haltingOnFirstError {
      for count in self.testCounts {
        // we need distinct values in our array or else our test should fail
        let integers = [Int](
          repeating: count,
          count: count
        )
        
        // since our reference is invalid everything should fail:
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenInteger($0)
            }
          )
        )
      }
    }
  }
  
  func testEqualityCoherenceTestsAgainstAscendingArray() {
    self.haltingOnFirstError {
      for count in self.testCounts {
        let integers = 0..<count
        // reference is coherent:
        XCTAssertTrue(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers
          )
        )
        // this broken type *should actually pass* this test,
        // because only its *comparisons* are broken:
        XCTAssertTrue(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        
        // but both of these should fail b/c they have broken *equality*:
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenEqualityInteger($0)
            }
          ),
          "Failed for `HDXLConfirmCoherentEquality(forDistinctValues: \(String(reflecting: (integers.map() {BrokenEqualityInteger($0)}))))!"
        )
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenInteger($0)
            }
          )
        )
      }
    }
  }

  func testEqualityCoherenceTestsAgainstDescendingArray() {
    self.haltingOnFirstError {
      for count in self.testCounts {
        let integers = (0..<count).reversed()
        // reference is coherent:
        XCTAssertTrue(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers
          )
        )
        // this broken type *should actually pass* this test,
        // because only its *comparisons* are broken:
        XCTAssertTrue(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenComparisonInteger($0)
            }
          )
        )
        
        // but both of these should fail b/c they have broken *equality*:
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenEqualityInteger($0)
            }
          )
        )
        XCTAssertFalse(
          HDXLConfirmCoherentEquality(
            forDistinctValues: integers.map() {
              BrokenInteger($0)
            }
          )
        )
      }
    }
  }

}

