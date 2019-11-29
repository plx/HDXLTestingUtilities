//
//  CodableTestingSupport.swift
//  

import Foundation
import XCTest

// -------------------------------------------------------------------------- //
// MARK: `Codable` Round-Trip Verification
// -------------------------------------------------------------------------- //

/// Utility to verify that an ostensibly-codable object successfully round-trips
/// through the encoder/decoder process.
///
/// - parameter value: The value to round-trip through the encode/decode process.
///
/// - note: Currently only checks `JSONEncoder` and `JSONDecoder`, but will add others as I get to them.
///
@inlinable
public func HDXLAssertCodableRoundTrip<T>(_ value: T)
  where T:Equatable & Codable {
    // will add more as I get to them
  HDXLAssertJSONCodableRoundTrip(value)
}

/// Work-alike for `HDXLAssertCodableRoundTrip(_:)`, except it returns `true` and `false`
/// instead of calling `XCTAssert(_)`-style methods.
///
/// - parameter value: The value to round-trip through the encode/decode process.
///
/// - returns: `true` iff `value` round-trips through the encode/decode process.
///
/// - note: Currently only checks `JSONEncoder` and `JSONDecoder`, but will add others as I get to them.
///
@inlinable
public func HDXLConfirmCodableRoundTrip<T>(_ value: T) -> Bool
  where T:Equatable & Codable {
    return HDXLConfirmJSONCodableRoundTrip(value)
}

// -------------------------------------------------------------------------- //
// MARK: JSON-Specific `Codable` Round-Trip Verification
// -------------------------------------------------------------------------- //

/// Utility to verify that `value` encodes-and-decodes to itself (or, at least,
/// to something `==` to it). This specifically uses the `JSON`-flavored encoder
/// and decoder; intend to include others if I remember to come back and find them.
@inlinable
public func HDXLAssertJSONCodableRoundTrip<T>(_ value: T)
  where T:Equatable & Codable {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let encoding: Data
    do {
      encoding = try encoder.encode(value)
    }
    catch let e {
      XCTFail("Got encoding error '\(e.localizedDescription)' trying to encode \(value)!")
      return
    }
    let destination: T
    do {
      destination = try decoder.decode(
        T.self,
        from: encoding
      )
    }
    catch let e {
      XCTFail("Got decoding error '\(e.localizedDescription)' trying to decode \(value) from data: \(encoding)!")
      return
    }
    XCTAssertEqual(
      value,
      destination
    )
}

/// Work-alike for `HDXLAssertJSONCodableRoundTrip(_:)` that returns a simple
/// `true`-or-`false` result if the process succeeds or fails.
@inlinable
public func HDXLConfirmJSONCodableRoundTrip<T>(_ value: T) -> Bool
  where T:Equatable & Codable {
    do {
      let encoder = JSONEncoder()
      let decoder = JSONDecoder()
      let encoding = try encoder.encode(value)
      let destination = try decoder.decode(
        T.self,
        from: encoding
      )
      return value == destination
    }
    catch {
      return false
    }
}
