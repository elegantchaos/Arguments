import XCTest
@testable import Arguments

final class ArgumentsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Arguments().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
