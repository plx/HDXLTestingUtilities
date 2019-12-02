//
//  SynchronizedIndexSet.swift
//

import Foundation
import os

// -------------------------------------------------------------------------- //
// MARK: SynchronizedIndexSet - Definition
// -------------------------------------------------------------------------- //

/// An `IndexSet` wrapper allowing safe, concurrent *insertion* from any queue/thread.
///
/// Motivating use case is, say, performing an "exhaustive check" style of unit
/// test, performing the checks in parallel, keeping track of (the indices of)
/// any failed checks, and then reporting the final results all-at-once.
///
/// As a minor note, just like the counters this only supports an *increasing* API,
/// in the sense that there are no avaiable mutations that *remove* indices.
public final class SynchronizedIndexSet : CustomStringConvertible, CustomDebugStringConvertible {
    
  // ------------------------------------------------------------------------ //
  // MARK: Stored Properties
  // ------------------------------------------------------------------------ //

  /// Developer-supplied string identifying this specific synchronized index set.
  public let identifier: String
  
  /// The wrapped index set.
  ///
  /// - note: Keeping it prefixed with `_indexSet` in case I want to rename `currentIndexSet` back to just `indexSet`.
  ///
  @usableFromInline
  internal var _indexSet: IndexSet = IndexSet()
  
  /// The lock with which we guard access to `_indexSet`.
  @usableFromInline
  internal var synchronizationLock: os_unfair_lock = os_unfair_lock()

  // ------------------------------------------------------------------------ //
  // MARK: Initialization & Construction
  // ------------------------------------------------------------------------ //

  /// Primary initializer.
  ///
  /// - parameter identifier: An arbitrary string used to identify this specific index set.
  ///
  @inlinable
  public required init(identifier: String) {
    self.identifier = identifier
  }
  
  /// Convenience to get an index set named after the current method.
  /// In my experience that's sufficient for the vast bulk of unit tests.
  @inlinable
  public static func forCurrentMethod(_ function: StaticString = #function) -> SynchronizedIndexSet {
    return SynchronizedIndexSet(identifier: "\(function)")
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Primary API
  // ------------------------------------------------------------------------ //

  /// Obtains the current index set; "safe" in that access is guarded by the lock
  /// guarding insertion, but "unsafe" in that using this value mid-concurrent-iteration
  /// will necessarily risk introducing race conditions.
  @inlinable
  public var currentIndexSet: IndexSet {
    get {
      return self.perform() {
        [unowned self]
        () -> IndexSet
        in
        return self._indexSet
        // ^ maybe dangerous for concurrent read/write, but
        // fine for a lifecycle like:
        //
        // 1. birth
        // 2. concurrent, write-only updating
        // 3. serial, read-only verification
        //
        // ...which is why this is in `HDXLTestingUtilities` and not `HDXLCommonUtilities`.
      }
    }
  }
  
  /// Returns the *current count*; all caveats for `currentIndexSet` apply here, also.
  ///
  /// That said, note that this is monotonic non-decreasing: our index set only-ever
  /// gets bigger--or at least never-ever gets any smaller--and thus the value returned
  /// here will only-ever increase.
  @inlinable
  public var currentCount: Int {
    get {
      return self.perform() {
        [unowned self]
        () -> Int
        in
        return self._indexSet.count
      }
    }
  }
  
  /// Returns `true` iff the index set is currently-empty; all caveats for `currentIndexSet` apply here, also.
  ///
  /// That said, this exists in cases like "doing iteration in large batches, tracking
  /// failures in the index set, and want to bail out early once we hit any failures".
  ///
  /// Note that b/c the underlying index set only-ever increases in count, this
  /// method will start at `true` and then--perhaps--flip over to `false`; it *won't*
  /// oscillate between the two.
  ///
  @inlinable
  public var isEmpty: Bool {
    get {
      return self.perform() {
        [unowned self]
        () -> Bool
        in
        return self._indexSet.isEmpty
      }
    }
  }
  
  /// Returns `true` iff the index set is currently-non-empty; all caveats for `currentIndexSet` apply here, also.
  ///
  /// That said, this exists in cases like "doing iteration in large batches, tracking
  /// failures in the index set, and want to bail out early once we hit any failures".
  ///
  /// Note that b/c the underlying index set only-ever increases in count, this
  /// method will start at `false` and then--perhaps--flip over to `true`; it *won't*
  /// oscillate between the two.
  ///
  @inlinable
  public var isNonEmpty: Bool {
    get {
      return !self.isEmpty
    }
  }
  
  /// Inserts `index` into our own index set.
  @inlinable
  public func insert(index: Int) {
    self.perform() {
      [unowned self]
      () -> Void
      in
      let _ = self._indexSet.insert(index)
    }
  }

  /// Inserts the indices in `indices` into our own index set.
  @inlinable
  public func insert(integersIn indices: Range<Int>) {
    guard !indices.isEmpty else {
      return
    }
    self.perform() {
      [unowned self]
      () -> Void
      in
      let _ = self._indexSet.insert(integersIn: indices)
    }
  }
  
  /// Inserts the indices in `indexSet` into our own index set.
  ///
  /// - note: I wish this was called `insert`, still, but I'm matching `IndexSet`.
  @inlinable
  public func union(_ indexSet: IndexSet) {
    guard !indexSet.isEmpty else {
      return
    }
    self.perform() {
      [unowned self]
      () -> Void
      in
      let _ = self._indexSet.union(indexSet)
    }
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: CustomStringConvertible
  // ------------------------------------------------------------------------ //
  
  @inlinable
  public var description: String {
    get {
      return "SynchronizedIndexSet(identifier: \"\(self.identifier)\")"
    }
  }
  
  @inlinable
  public var debugDescription: String {
    get {
      // good-enough for now, but might revisit later
      return self.description
    }
  }

}

// ------------------------------------------------------------------------ //
// MARK: SynchronizedIndexSet - Synchronization Support
// ------------------------------------------------------------------------ //

internal extension SynchronizedIndexSet {

  /// Convenience vis-a-vis `os_unfair_lock_lock` and `os_unfair_lock_unlock`.
  @inlinable
  var lock: os_unfair_lock_t {
    get {
      return UnsafeMutablePointer<os_unfair_lock>(&self.synchronizationLock)
    }
  }

  /// Internal "do X while holding the lock" method; used to use the one from
  /// `HDXLCommonUtilities` but reimplemented, here, as part splitting off the
  /// testing utilities into their own package.
  @inlinable
  func perform<R>(_ work: () throws -> R) rethrows -> R {
    let lock = self.lock
    os_unfair_lock_lock(lock)
    defer { os_unfair_lock_unlock(lock) }
    return try work()
  }

}
