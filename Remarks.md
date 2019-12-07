# HDXLTestingUtilities - Remarks

This document contains miscellaneous *remarks* vis-a-vis the contents of the package, the Swift language and ecyosystem, and so on and so forth.

## Performance Issues

Swift unit tests *generally* use `Debug` builds when they execute. `Debug` builds, however, *generally* are around an order of magnitude slower when executing *generic* code--`Debug` doesn't attempt aggressive inlining, aggressive specialization, or really...aggressive anything. 

This slowness imposes extreme practical difficulties for unit tests that generate a lot of example values and then verify said values--you can certainly *write* exhaustive tests, you can certainly *attempt* property-based testing, etc., but when you do, you run a risk of writing tests that run for hours.

This, ironically, prevented the functionality in this library from permanent incorporation in the test suite that inspired it: I *wrote* the index/collection verification logic to validate the complex index-manipulation code in [`HDXLAlgebraicUtilities`](https://github.com/plx/HDXLAlgebraicUtilities), it *did* help shake out a lot of subtle bugs, but those tests were *far too slow* to keep around indefinitely.

This doesn't make the functionality here useless--it helps tremendously when verifying a custom collection's initial implementation--but to use it you will have to think a bit strategically (different test suites, external shakedown suites, or just shifting to narrowly-targeted unit tests once the initial bugs have been shaken out).

## Index/Collection Redundancy

Swift's current design for collections (a) assigns responsibility for *moving* indices to the collections but also (b) *requires* indices to know how they're ordered and, further, (c) requires *coherency* between that index-level ordering and the implicit ordering from the `Collection`, itself.

Let me unpack that: `Index` must be `Comparable`, and thus e.g. if `a` and `b` are indices it must be possible to evaluate `a < b` solely by evaluating the contents of those indices. At the same time, however, `Collection` contains a large index-movement API, excerpted below:

```swift
protocol Collection {  
  func distance(from start: Index, to limit: Index) -> Int
  func index(after i: Index) -> Index
  func index(_ i: Index, offsetBy distance: Int) -> Index
}
```

...from which one can derive an ordering of those indices--`a < b` iff `collection.distance(from: a, to: b) > 0` (and so on and so forth); those  orderings must agree with each other.

Although *generally* easy to achieve, the inherent complexity of this multi-method, multi-type semantic contract means leaves complex custom collections at risk for *subtle* implementation mistakes inducing *difficult-to-observe* coherence issues.

Here's a real-life example: suppose we have a "chain collection" like so:

```swift
struct Chain4Collection<A:Collection,B:Collection,C:Collection,D:Collection> 
  where 
  A.Element == B.Element,
  A.Element == C.Element,
  A.Element == D.Element {

  enum Index {
    case a(A.Index)
    case b(B.Index)
    case c(C.Index)
    case d(D.Index)
    case end
  }  
}
```

Implementing *correct* `==` and `<` operators for `Chain4Collection.Index` is straightforward. 

Less straightforward, however, is implementing `Chain4Collection.distance(from:to:)`. Note that this is a method we really *should* implement--if we *don't*, here, the default implementation will only give us `O(distance)` performance. Implementing `distance(from:to:)` doesn't require sophisticated algorithms, but is extremely fiddly and error-prone. It's also something that's easy to get correct-enough to look right vis-a-vis `<`, but be broken in subtler ways (e.g. such that the distance from `x` to `y` and then from `y` to `z` comes out differently than the distance from `x` to `z`, directly).

For broader property testing I'd rather use a well-developed, pre-existing property-testing package...but I've found the presence of *subtle* errors along the above lines difficult to eliminate *except* via exhaustive testing as supplied in this package.

## Observation: Can't Test Test Failure

There doesn't appear to be any realistic way to say "expect test failure within this closure"; what I mean is, e.g., we have things like `XCTAssertThrow(foo())`--which fails iff `foo()` *doesn't* throw--but we don't have something like this:

```swift
func testCustomTestAssertion() {
  // this type has an intentionally-broken `Codable` implementation;
  // we want to confirm `HDXLAssertCodableRoundTrip` will *catch* that bug:
  let willNotRoundTrip = BrokenCodableImplementation(wrapping: 0)
  self.expectAtLeastOneTestFailure() {
    // within this scope, test failures are treated as success (and we would
    // fail the test *iff* we didn't report any "failures" in here)
    HDXLAssertCodableRoundTrip(
      willNotRoundTrip
    )
  }  
}
```

This makes it hard to actually test the custom test assertions, b/c although we *can* test for false failures, we *can't* test for true failures. I can see why such an API might be tricky atop the current `XCTest` stack: you'd ideally have a way to indicate which failures to treat as successes and which failures to treat as actual failures, but there's no good way to do that within the existing API; the assertions don't have types, or identifiers, or anything else that could be used to interpret "which failures are the expected failures we temporarily see as success, and which are unexpected failures we continue treat as failures".

## Subtle Limitations: `==` and `!=`

Whereas the `Comparable` protocol includes all four ordering methods--`<`, `<=`, `>`, and `>=`--the `Equatable` protocol only includes `==`; `!=` is *provided* via a protocol extension, but isn't, itself, an extension point. That `!=` isn't overrideable seems to be a change from earlier iterations of Swift, and at time of writing Apple's online documentation for `Equatable` hasn't caught up:

- the function-level documentation still describes the protocol as *requiring* both `==` and `!=`
- the documentation overview is written as-if one still might wish to providing a custom `!=` (whereas for `!=` *not* an extension point, it's arguably very ill-advised to provide a custom implementation)

I bring this up because the status of `!=` surprised me and it meant I had trouble, at first, figuring out why my types with deliberately-broken equality logic were *satisfying* my equality-coherence checks--especially b/c no similar issue arose vis-a-vis `Comparable`.
