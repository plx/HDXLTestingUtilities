# HDXLTestingUtilities

Miscellaneous minor unit-testing utilities falling within three categories:

1. an ever-growing set of `XCTAssert...`-style test assertions
2. useful minor extensions on `XCTTestCase`
3. support for verifying the *coherence* of various protocol conformances:
  - is your `==` logically-coherent?
  - is your `<` logically-coherent?
  - does your `Collection` agree with its `Index` about, e.g., ordering?
  
(1) and (2) are both useful, but category (3) is really *why* this library exists--any error caught, here, will avoid literal hours of frustration while diving into some subtle misbehavior.

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
