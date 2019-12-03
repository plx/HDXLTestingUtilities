//
//  ProbeTypealiases.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: Probe Typealiases
// -------------------------------------------------------------------------- //

/// Typealias for a *labeled*, arity-2 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity2Probe<A,B> = (
  a: A,
  b: B
)

/// Typealias for a *labeled*, arity-3 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity3Probe<A,B,C> = (
  a: A,
  b: B,
  c: C
)

/// Typealias for a *labeled*, arity-4 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity4Probe<A,B,C,D> = (
  a: A,
  b: B,
  c: C,
  d: D
)

/// Typealias for a *labeled*, arity-5 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity5Probe<A,B,C,D,E> = (
  a: A,
  b: B,
  c: C,
  d: D,
  e: E
)

/// Typealias for a *labeled*, arity-6 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity6Probe<A,B,C,D,E,F> = (
  a: A,
  b: B,
  c: C,
  d: D,
  e: E,
  f: F
)

/// Typealias for a *labeled*, arity-7 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity7Probe<A,B,C,D,E,F,G> = (
  a: A,
  b: B,
  c: C,
  d: D,
  e: E,
  f: F,
  g: G
)

/// Typealias for a *labeled*, arity-8 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity8Probe<A,B,C,D,E,F,G,H> = (
  a: A,
  b: B,
  c: C,
  d: D,
  e: E,
  f: F,
  g: G,
  h: H
)

/// Typealias for a *labeled*, arity-9 tuple.
///
/// - note: Necessary until/unless I get the algebraic-utilities out the door (and as a dependency here).
///
public typealias Arity9Probe<A,B,C,D,E,F,G,H,I> = (
  a: A,
  b: B,
  c: C,
  d: D,
  e: E,
  f: F,
  g: G,
  h: H,
  i: I
)

// -------------------------------------------------------------------------- //
// MARK: Uniform Probe Typealiases
// -------------------------------------------------------------------------- //

/// Shorthand for arity-2 probes of homogeneous type.
public typealias UniformArity2Probe<T> = Arity2Probe<T,T>

/// Shorthand for arity-3 probes of homogeneous type.
public typealias UniformArity3Probe<T> = Arity3Probe<T,T,T>

/// Shorthand for arity-4 probes of homogeneous type.
public typealias UniformArity4Probe<T> = Arity4Probe<T,T,T,T>

/// Shorthand for arity-5 probes of homogeneous type.
public typealias UniformArity5Probe<T> = Arity5Probe<T,T,T,T,T>

/// Shorthand for arity-6 probes of homogeneous type.
public typealias UniformArity6Probe<T> = Arity6Probe<T,T,T,T,T,T>

/// Shorthand for arity-7 probes of homogeneous type.
public typealias UniformArity7Probe<T> = Arity7Probe<T,T,T,T,T,T,T>

/// Shorthand for arity-8 probes of homogeneous type.
public typealias UniformArity8Probe<T> = Arity8Probe<T,T,T,T,T,T,T,T>

/// Shorthand for arity-9 probes of homogeneous type.
public typealias UniformArity9Probe<T> = Arity9Probe<T,T,T,T,T,T,T,T,T>

