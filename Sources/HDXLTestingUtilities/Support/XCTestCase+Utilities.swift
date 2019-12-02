//
//  XCTestCase+Utilities.swift
//

import Foundation
import XCTest

public extension XCTestCase {
  
  /// Performs `activity` with `continueAfterFailure = false`, then restores the
  /// prior value of `continueAfterFailure`.
  ///
  /// This exists to let individual tests--and individual blocks therein--express
  /// their own preference vis-a-vis continue-after-failure; without this, either
  /// (a) each test-case subclass sets a common policy for all tests, (b) each
  /// method contains its own set-and-reset boilerplate, (c) you overide setup/teardown
  /// to reset the state to the common policy for that subclass, or (d) you risk
  /// unexpected behavior due to individual tests manipulating this shared state.
  ///
  /// In the long run a richer `XCTTestCase` design that derived "continue after
  /// failure" by examining a stack of, say, `XCTestExecutionPreference` might
  /// be preferable, but for now this is a reasonable compromise.
  ///
  /// - seealso: `continuingOnError(_:)`, which has the opposite semantic.
  ///
  @nonobjc
  @inlinable
  func haltingOnFirstError(_ activity: () -> Void) {
    self.with(
      continueAfterFailure: false,
      activity: activity
    )
  }
  
  /// Performs `activity` with `continueAfterFailure = true`, then restores the
  /// prior value of `continueAfterFailure`.
  ///
  /// This exists to let individual tests--and individual blocks therein--express
  /// their own preference vis-a-vis continue-after-failure; without this, either
  /// (a) each test-case subclass sets a common policy for all tests, (b) each
  /// method contains its own set-and-reset boilerplate, (c) you overide setup/teardown
  /// to reset the state to the common policy for that subclass, or (d) you risk
  /// unexpected behavior due to individual tests manipulating this shared state.
  ///
  /// In the long run a richer `XCTTestCase` design that derived "continue after
  /// failure" by examining a stack of, say, `XCTestExecutionPreference` might
  /// be preferable, but for now this is a reasonable compromise.
  ///
  /// - seealso: `haltingOnFirstError(_:)`, which has the opposite semantic.
  ///
  @nonobjc
  @inlinable
  func continuingOnError(_ activity: () -> Void) {
    self.with(
      continueAfterFailure: true,
      activity: activity
    )
  }
  
  /// Helper method for `continuingOnError(_:)` and `haltingOnFirstError(_:)`.
  @nonobjc
  @inlinable
  internal func with(continueAfterFailure: Bool, activity: () -> Void) {
    let previous = self.continueAfterFailure
    defer { self.continueAfterFailure = previous }
    self.continueAfterFailure = continueAfterFailure
    activity()
  }
  
}
