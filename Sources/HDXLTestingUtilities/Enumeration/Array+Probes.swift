//
//  Array+Probes.swift
//

import Foundation

public extension Array {
  
  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity2Probe<Element>) {
    self = [
      probe.a,
      probe.b
    ]
  }

  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity3Probe<Element>) {
    self = [
      probe.a,
      probe.b,
      probe.c
    ]
  }

  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity4Probe<Element>) {
    self = [
      probe.a,
      probe.b,
      probe.c,
      probe.d
    ]
  }

  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity5Probe<Element>) {
    self = [
      probe.a,
      probe.b,
      probe.c,
      probe.d,
      probe.e
    ]
  }

  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity6Probe<Element>) {
    self = [
      probe.a,
      probe.b,
      probe.c,
      probe.d,
      probe.e,
      probe.f
    ]
  }

  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity7Probe<Element>) {
    self = [
      probe.a,
      probe.b,
      probe.c,
      probe.d,
      probe.e,
      probe.f,
      probe.g
    ]
  }

  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity8Probe<Element>) {
    self = [
      probe.a,
      probe.b,
      probe.c,
      probe.d,
      probe.e,
      probe.f,
      probe.g,
      probe.h
    ]
  }

  /// Constructs an `Array` from the contents of a (labeled) probe tuple.
  @inlinable
  init(_ probe: UniformArity9Probe<Element>) {
    self = [
      probe.a,
      probe.b,
      probe.c,
      probe.d,
      probe.e,
      probe.f,
      probe.g,
      probe.h,
      probe.i
    ]
  }

}
