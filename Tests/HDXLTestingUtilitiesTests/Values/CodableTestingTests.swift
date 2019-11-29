//
//  CodableTestingTests.swift
//

import Foundation
import XCTest
@testable import HDXLTestingUtilities

class CodableTestingTests: XCTestCase {

  func testRoundTripsOnIntegers() {
    self.haltingOnFirstError {
      for probe in 0..<100 {
        XCTAssertTrue(
          HDXLConfirmCodableRoundTrip(probe)
        )
        HDXLAssertCodableRoundTrip(probe)
      }
    }
  }
  
  func testRoundTripsOnBrokenIntegers() {
    self.haltingOnFirstError {
      for probe in 1...100 {
        let value = BrokenCodableInteger(probe)
        switch 0 == probe.quotientAndRemainder(dividingBy: 2).remainder {
        case true:
          XCTAssertFalse(
            HDXLConfirmCodableRoundTrip(value)
          )
        case false:
          XCTAssertTrue(
            HDXLConfirmCodableRoundTrip(value)
          )
          HDXLAssertCodableRoundTrip(value)
        }
      }
    }
  }

}


