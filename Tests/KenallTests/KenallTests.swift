import XCTest
@testable import Kenall

final class KenallTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Kenall().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
