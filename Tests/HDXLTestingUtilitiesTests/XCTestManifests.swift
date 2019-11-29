import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
      testCase(PairwiseDistinctTests.allTests),
      testCase(SynchronizedCounterTests.allTests),
      testCase(SynchronizedIndexSetTests.allTests),
      testCase(EqualityTestingSupportTests.allTests),
      testCase(OrderingTestingSupportTests.allTests)
    ]
}
#endif
