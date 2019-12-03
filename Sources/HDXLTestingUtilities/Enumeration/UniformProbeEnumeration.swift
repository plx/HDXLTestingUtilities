//
//  UniformProbeEnumeration.swift
//

import Foundation

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity2CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    using: visitor
  )
}

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity3CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    values,
    using: visitor
  )
}

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity4CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    values,
    values,
    using: visitor
  )
}

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity5CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    values,
    values,
    values,
    using: visitor
  )
}

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity6CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    values,
    values,
    values,
    values,
    using: visitor
  )
}

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity7CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    values,
    values,
    values,
    values,
    values,
    using: visitor
  )
}

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity8CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    values,
    values,
    values,
    values,
    values,
    values,
    using: visitor
  )
}

/// Shorthand for iterating the n-ary cartesian product of a collection with itself.
@inlinable
public func EnumerateUniformProbes<K:Collection>(
  _ values: K,
  using visitor: (UniformArity9CollectionProbe<K>) -> Void) {
  guard !values.isEmpty else {
    return
  }
  EnumerateProbes(
    values,
    values,
    values,
    values,
    values,
    values,
    values,
    values,
    values,
    using: visitor
  )
}
