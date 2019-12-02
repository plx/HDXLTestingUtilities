//
//  UnfairLockSynchronizedCounter.swift
//

import Foundation
import os

// -------------------------------------------------------------------------- //
// MARK: DispatchSynchronizedCounter - Alias
// -------------------------------------------------------------------------- //

/// If you want a `SynchronizedCounter` you actually want `UnfairLockSynchronizedCounter`
/// 99% of the time, whence this typealias. I *don't* want to write test code against a
/// *protocol*, however, b/c in the scenarios you want this type you would generally
/// want to minimize your overhead.
public typealias SynchronizedCounter = UnfairLockSynchronizedCounter

// -------------------------------------------------------------------------- //
// MARK: DispatchSynchronizedCounter - Definition
// -------------------------------------------------------------------------- //

/// Simplistic "synchronized counter" class: you can *safely* call `incrementCount()`
/// from any thread/queue. If you don't mind introducing potential race conditions
/// into your code, you can also call `currentCount` to get the current count.
///
/// The reason this class exists, here, specifically, is to support testing parallel
/// iteration strategies: if, say, some parallel code will *ostensibly* visit 1,000,000
/// elements, you can (a) increment an instance of this class in each visit,
/// and then (b) make sure the final count matches the expected count.
///
/// As a minor note, keep in mind that the API only supports *increasing* the
/// count: this *doesn't* free us from the risk of race conditions if you access
/// it *during* concurrent iteration, but *does* let us assume it won't, say, go
/// from non-zero back to zero.
///
/// That's it, and that's all this is meant to do.
///
/// Well, as a final note: this is *much faster* than the functional-equivalent
/// `DispatchSynchronizedCounter` and is thus almost-always "the right choice".
/// You should thus *always* use this type *unless* you're specifically *testing*
/// this type, itself.
public final class UnfairLockSynchronizedCounter {
  
  // ------------------------------------------------------------------------ //
  // MARK: Stored Properties
  // ------------------------------------------------------------------------ //
    
  /// Developer-supplied identifier for this counter.
  public let identifier: String

  /// The actual counter.
  ///
  /// - note: Kept as `_count` in case I change `currentCount` back to just `count`.
  @usableFromInline
  internal var _count: Int = 0
  
  /// The lock with which we guard access to `_indexSet`.
  @usableFromInline
  internal var synchronizationLock: os_unfair_lock = os_unfair_lock()

  // ------------------------------------------------------------------------ //
  // MARK: Initialization & Construction
  // ------------------------------------------------------------------------ //

  /// Primary initializer.
  ///
  /// - parameter identifier: An arbitrary string identifying the counter.
  ///
  @inlinable
  public required init(identifier: String) {
    self.identifier = identifier
  }
  
  /// Convenience to get a counter named after the current method; useful for
  /// typical unit tests, which in my experience generally require only a single counter.
  @inlinable
  public static func forCurrentMethod(_ function: StaticString = #function) -> UnfairLockSynchronizedCounter {
    return UnfairLockSynchronizedCounter(identifier: "\(function)")
  }
    
  // ------------------------------------------------------------------------ //
  // MARK: Primary API
  // ------------------------------------------------------------------------ //

  /// Obtain the current count. It's "synchronized" in the sense that access
  /// to the count occurs on the `synchronizationQueue`, but note that accessing
  /// the count mid-iteration is a good way to introduce race conditions into
  /// your code; better to just wait until you're done.
  ///
  @inlinable
  public var currentCount: Int {
    get {
      return self.perform() {
        [unowned self]
        () -> Int
        in
        return self._count
      }
    }
  }
  
  /// Call to increment the current count.
  @inlinable
  public func incrementCount() {
    self.perform() {
      [unowned self]
      () -> Void
      in
      self._count += 1
    }
  }

  /// `true` iff the count has never been incremented.
  ///
  /// All caveats applicable to `currentCount` apply here; exists in case you
  /// are doing property testing or other large-scale "exhaustive" tests and want
  /// a streamlined way to stop doing the work--if not the iteration--once you've
  /// hit some failures.
  ///
  /// - warning: This is synchronous and thus "blocking"; checking it frequently can thus "de-parallelize" your iteration!
  ///
  @inlinable
  public var isZero: Bool {
    get {
      return self.currentCount == 0
    }
  }

  /// `true` iff the count has been incremented at least once.
  ///
  /// All caveats applicable to `currentCount` apply here; exists in case you
  /// are doing property testing or other large-scale "exhaustive" tests and want
  /// a streamlined way to stop doing the work--if not the iteration--once you've
  /// hit some failures.
  ///
  /// - warning: This is synchronous and thus "blocking"; checking it frequently can thus "de-parallelize" your iteration!
  ///
  @inlinable
  public var isNonZero: Bool {
    get {
      return self.currentCount > 0
    }
  }

  
}

// -------------------------------------------------------------------------- //
// MARK: UnfairLockSynchronizedCounter - Synchronization Support
// -------------------------------------------------------------------------- //

internal extension UnfairLockSynchronizedCounter {
  
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
