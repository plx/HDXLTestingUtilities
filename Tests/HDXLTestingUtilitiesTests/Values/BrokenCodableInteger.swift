//
//  BrokenCodableInteger.swift
//

import Foundation

struct BrokenCodableInteger : Equatable {
  
  var value: Int
  
  init(_ value: Int) {
    self.value = value
  }
  
}

extension BrokenCodableInteger : Codable {
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(
      // => 0 for even self.value,
      // => self.value for odd self.value
      self.value * self.value.quotientAndRemainder(dividingBy: 2).remainder
    )
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(Int.self)
    self.init(value)
  }
  
}
