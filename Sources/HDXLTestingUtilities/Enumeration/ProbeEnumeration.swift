//
//  ProbeEnumeration.swift
//

import Foundation

/// Unstoppable iteration, calling `visitor` once on each element of the cartesian
/// product of the arguments. Exists, here, for use in testing until such time as
/// I get the algebraic-utilities back up and running.
@inlinable
public func EnumerateProbes<A,B>(
  _ aa: A,
  _ bb: B,
  using visitor: (Arity2CollectionProbe<A,B>) -> Void)
  where
  A:Collection,
  B:Collection {
    for a in aa {
      for b in bb {
        visitor((
          a: a,
          b: b
        ))
      }
    }
}

/// Unstoppable iteration, calling `visitor` once on each element of the cartesian
/// product of the arguments. Exists, here, for use in testing until such time as
/// I get the algebraic-utilities back up and running.
@inlinable
public func EnumerateProbes<A,B,C>(
  _ aa: A,
  _ bb: B,
  _ cc: C,
  using visitor: (Arity3CollectionProbe<A,B,C>) -> Void)
  where
  A:Collection,
  B:Collection,
  C:Collection {
    for a in aa {
      for b in bb {
        for c in cc {
          visitor((
            a: a,
            b: b,
            c: c
          ))
        }
      }
    }
}

/// Unstoppable iteration, calling `visitor` once on each element of the cartesian
/// product of the arguments. Exists, here, for use in testing until such time as
/// I get the algebraic-utilities back up and running.
@inlinable
public func EnumerateProbes<A,B,C,D>(
  _ aa: A,
  _ bb: B,
  _ cc: C,
  _ dd: D,
  using visitor: (Arity4CollectionProbe<A,B,C,D>) -> Void)
  where
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection {
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            visitor((
              a: a,
              b: b,
              c: c,
              d: d
            ))
          }
        }
      }
    }
}

@inlinable
public func EnumerateProbes<A,B,C,D,E>(
  _ aa: A,
  _ bb: B,
  _ cc: C,
  _ dd: D,
  _ ee: E,
  using visitor: (Arity5CollectionProbe<A,B,C,D,E>) -> Void)
  where
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection {
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              visitor((
                a: a,
                b: b,
                c: c,
                d: d,
                e: e
              ))
            }
          }
        }
      }
    }
}

/// Unstoppable iteration, calling `visitor` once on each element of the cartesian
/// product of the arguments. Exists, here, for use in testing until such time as
/// I get the algebraic-utilities back up and running.
@inlinable
public func EnumerateProbes<A,B,C,D,E,F>(
  _ aa: A,
  _ bb: B,
  _ cc: C,
  _ dd: D,
  _ ee: E,
  _ ff: F,
  using visitor: (Arity6CollectionProbe<A,B,C,D,E,F>) -> Void)
  where
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection {
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              for f in ff {
                visitor((
                  a: a,
                  b: b,
                  c: c,
                  d: d,
                  e: e,
                  f: f
                ))
              }
            }
          }
        }
      }
    }
}

/// Unstoppable iteration, calling `visitor` once on each element of the cartesian
/// product of the arguments. Exists, here, for use in testing until such time as
/// I get the algebraic-utilities back up and running.
@inlinable
public func EnumerateProbes<A,B,C,D,E,F,G>(
  _ aa: A,
  _ bb: B,
  _ cc: C,
  _ dd: D,
  _ ee: E,
  _ ff: F,
  _ gg: G,
  using visitor: (Arity7CollectionProbe<A,B,C,D,E,F,G>) -> Void)
  where
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection {
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              for f in ff {
                for g in gg {
                  visitor((
                    a: a,
                    b: b,
                    c: c,
                    d: d,
                    e: e,
                    f: f,
                    g: g
                  ))
                }
              }
            }
          }
        }
      }
    }
}

/// Unstoppable iteration, calling `visitor` once on each element of the cartesian
/// product of the arguments. Exists, here, for use in testing until such time as
/// I get the algebraic-utilities back up and running.
@inlinable
public func EnumerateProbes<A,B,C,D,E,F,G,H>(
  _ aa: A,
  _ bb: B,
  _ cc: C,
  _ dd: D,
  _ ee: E,
  _ ff: F,
  _ gg: G,
  _ hh: H,
  using visitor: (Arity8CollectionProbe<A,B,C,D,E,F,G,H>) -> Void)
  where
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection,
  H:Collection {
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              for f in ff {
                for g in gg {
                  for h in hh {
                    visitor((
                      a: a,
                      b: b,
                      c: c,
                      d: d,
                      e: e,
                      f: f,
                      g: g,
                      h: h
                    ))
                  }
                }
              }
            }
          }
        }
      }
    }
}

/// Unstoppable iteration, calling `visitor` once on each element of the cartesian
/// product of the arguments. Exists, here, for use in testing until such time as
/// I get the algebraic-utilities back up and running.
@inlinable
public func EnumerateProbes<A,B,C,D,E,F,G,H,I>(
  _ aa: A,
  _ bb: B,
  _ cc: C,
  _ dd: D,
  _ ee: E,
  _ ff: F,
  _ gg: G,
  _ hh: H,
  _ ii: I,
  using visitor: (Arity9CollectionProbe<A,B,C,D,E,F,G,H,I>) -> Void)
  where
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  E:Collection,
  F:Collection,
  G:Collection,
  H:Collection,
  I:Collection {
    for a in aa {
      for b in bb {
        for c in cc {
          for d in dd {
            for e in ee {
              for f in ff {
                for g in gg {
                  for h in hh {
                    for i in ii {
                      visitor((
                        a: a,
                        b: b,
                        c: c,
                        d: d,
                        e: e,
                        f: f,
                        g: g,
                        h: h,
                        i: i
                      ))
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
}
