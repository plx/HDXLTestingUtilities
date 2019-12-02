//
//  DispatchSynchronizedCounter.swift
//

import Foundation
import Dispatch

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
/// Well, as a final note: the `UnfairLockSynchronizedCounter` is much faster and
/// thus almost-always "the right choice". This type exists because (a) it's easier
/// to get correct (for me, due to experience) and thus (b) it provides a "known-good"
/// implementation against-which I can then test the correctness of other implementations.
public final class DispatchSynchronizedCounter : CustomStringConvertible, CustomDebugStringConvertible {
  
  // ------------------------------------------------------------------------ //
  // MARK: Stored Properties
  // ------------------------------------------------------------------------ //

  /// Developer-supplied identifier for this counter; also incorporated into the dispatch-queue identifier.
  public let identifier: String
  
  /// The actual counter.
  ///
  /// - note: Kept as `_count` in case I change `currentCount` back to just `count`.
  @usableFromInline
  internal var _count: Int = 0
  
  /// Private queue used to synchronize access to the counter.
  @usableFromInline
  internal let synchronizationQueue: DispatchQueue
  
  // ------------------------------------------------------------------------ //
  // MARK: Initialization & Construction
  // ------------------------------------------------------------------------ //

  /// Primary initializer.
  ///
  /// - parameter identifier: An arbitrary string identifying the counter (and its queue).
  ///
  @inlinable
  public required init(identifier: String) {
    self.identifier = identifier
    self.synchronizationQueue = DispatchQueue(
      label: "com.hdxlproject.hdxltestingutilities.DispatchSynchronizedCounter('\(identifier)')",
      qos: .unspecified,
      attributes: .concurrent,
      autoreleaseFrequency: .inherit,
      target: nil
    )
  }
  
  /// Convenience to get a counter named after the current method; useful for
  /// typical unit tests, which in my experience generally require only a single counter.
  @inlinable
  public static func forCurrentMethod(_ function: StaticString = #function) -> DispatchSynchronizedCounter {
    return DispatchSynchronizedCounter(identifier: "\(function)")
  }
  
  // ------------------------------------------------------------------------ //
  // MARK: Primary API
  // ------------------------------------------------------------------------ //
  
  /// Obtain the current count. It's "synchronized" in the sense that access
  /// to the count occurs on the `synchronizationQueue`, but note that accessing
  /// the count mid-iteration is a good way to introduce race conditions into
  /// your code; better to just wait until you're done.
  ///
  /// - warning: This is synchronous and thus "blocking"; checking it frequently can thus "de-parallelize" your iteration!
  ///
  @inlinable
  public var currentCount: Int {
    get {
      dispatchPrecondition(condition: .notOnQueue(self.synchronizationQueue))
      return self.synchronizationQueue.sync() {
        [unowned self]
        () -> Int
        in
        return self._count
      }
    }
  }

  /// Call to increment the current count.
  ///
  /// - note: Asynchronous and thus "non-blocking".
  @inlinable
  public func incrementCount() {
    self.synchronizationQueue.async(flags: .barrier) {      
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

  // ------------------------------------------------------------------------ //
  // MARK: CustomStringConvertible
  // ------------------------------------------------------------------------ //
  
  @inlinable
  public var description: String {
    get {
      return "DispatchSynchronizedCounter(identifier: \"\(self.identifier)\")"
    }
  }

  // ------------------------------------------------------------------------ //
  // MARK: CustomDebugStringConvertible
  // ------------------------------------------------------------------------ //
  
  @inlinable
  public var debugDescription: String {
    get {
      return self.description
    }
  }

}
