# HDXLTestingUtilities

Miscellaneous minor unit-testing utilities falling within three categories:

1. useful, minor extensions on `XCTTestCase`
2. an ever-growing set of `XCTAssert...`-style test assertions
3. support for verifying the *coherence* of various protocol conformances:
  - is your `==` logically-coherent?
  - is your `<` logically-coherent?
  - does your `Collection` agree with its `Index` about, e.g., ordering?
  
(1) and (2) are both useful, but category (3) is really *why* this library exists--any error caught, here, will avoid literal hours of frustration while diving into some subtle misbehavior. Expanded commentary can be found in the [`Remarks.md` file, here](https://github.com/plx/HDXLTestingUtilities/Remarks.md).

This package is part of the HDXL project family of libraries, and was originally a part of [`HDXLCommonUtilities`](https://github.com/plx/HDXLCommonUtilities).