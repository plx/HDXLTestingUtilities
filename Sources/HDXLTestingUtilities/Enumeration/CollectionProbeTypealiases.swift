//
//  CollectionProbeTypealiases.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: Collection Probe Typealiases
// -------------------------------------------------------------------------- //

/// Typealias for a *labeled*, arity-2 tuple sourced from *collection elements*.
public typealias Arity2CollectionProbe<
  A:Collection,
  B:Collection>
  = Arity2Probe<
    A.Element,
    B.Element
  >

/// Typealias for a *labeled*, arity-5 tuple sourced from *collection elements*.
public typealias Arity3CollectionProbe<
  A:Collection,
  B:Collection,
  C:Collection>
  =
  Arity3Probe<
    A.Element,
    B.Element,
    C.Element
  >

/// Typealias for a *labeled*, arity-5 tuple sourced from *collection elements*.
public typealias Arity4CollectionProbe<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection>
  =
  Arity4Probe<
    A.Element,
    B.Element,
    C.Element,
    D.Element
  >

/// Typealias for a *labeled*, arity-5 tuple sourced from *collection elements*.
public typealias Arity5CollectionProbe<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection>
  =
  Arity5Probe<
    A.Element,
    B.Element,
    C.Element,
    D.Element,
    E.Element
  >

/// Typealias for a *labeled*, arity-6 tuple sourced from *collection elements*.
public typealias Arity6CollectionProbe<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection>
  =
  Arity6Probe<
    A.Element,
    B.Element,
    C.Element,
    D.Element,
    E.Element,
    F.Element
  >

/// Typealias for a *labeled*, arity-7 tuple sourced from *collection elements*.
public typealias Arity7CollectionProbe<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection>
  =
  Arity7Probe<
    A.Element,
    B.Element,
    C.Element,
    D.Element,
    E.Element,
    F.Element,
    G.Element
  >

/// Typealias for a *labeled*, arity-8 tuple sourced from *collection elements*.
public typealias Arity8CollectionProbe<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection,
  H:Collection>
  =
  Arity8Probe<
    A.Element,
    B.Element,
    C.Element,
    D.Element,
    E.Element,
    F.Element,
    G.Element,
    H.Element
  >

/// Typealias for a *labeled*, arity-9 tuple sourced from *collection elements*.
public typealias Arity9CollectionProbe<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection,
  H:Collection,
  I:Collection>
  =
  Arity9Probe<
    A.Element,
    B.Element,
    C.Element,
    D.Element,
    E.Element,
    F.Element,
    G.Element,
    H.Element,
    I.Element
  >

// -------------------------------------------------------------------------- //
// MARK: Uniform Collection Probe Typealiases
// -------------------------------------------------------------------------- //

/// Shorthand for arity-2 collection probes of homogeneous type.
public typealias UniformArity2CollectionProbe<T:Collection> = Arity2CollectionProbe<T,T>

/// Shorthand for arity-3 collection probes of homogeneous type.
public typealias UniformArity3CollectionProbe<T:Collection> = Arity3CollectionProbe<T,T,T>

/// Shorthand for arity-4 collection probes of homogeneous type.
public typealias UniformArity4CollectionProbe<T:Collection> = Arity4CollectionProbe<T,T,T,T>

/// Shorthand for arity-5 collection probes of homogeneous type.
public typealias UniformArity5CollectionProbe<T:Collection> = Arity5CollectionProbe<T,T,T,T,T>

/// Shorthand for arity-6 collection probes of homogeneous type.
public typealias UniformArity6CollectionProbe<T:Collection> = Arity6CollectionProbe<T,T,T,T,T,T>

/// Shorthand for arity-7 collection probes of homogeneous type.
public typealias UniformArity7CollectionProbe<T:Collection> = Arity7CollectionProbe<T,T,T,T,T,T,T>

/// Shorthand for arity-8 collection probes of homogeneous type.
public typealias UniformArity8CollectionProbe<T:Collection> = Arity8CollectionProbe<T,T,T,T,T,T,T,T>

/// Shorthand for arity-9 collection probes of homogeneous type.
public typealias UniformArity9CollectionProbe<T:Collection> = Arity9CollectionProbe<T,T,T,T,T,T,T,T,T>
