import XCTest
@testable import Arguments

final class ArgumentsTests: XCTestCase {
    let docs = """
Test command.

Usage:
    test [<file>] [--flag] [--option=<value>]
    test wibble <file>
    test wobble <file>

Commands:
    wibble blah
    wobble blah
"""

    func testMissing() {
        let args = Arguments(documentation: docs, version: "1.0", arguments: ["test"])
        XCTAssertNil(args.option("flag"))
        XCTAssertNil(args.option("option"))
        XCTAssertFalse(args.command("wibble"))
        XCTAssertThrowsError(try args.expectedOption("flag"))
        XCTAssertThrowsError(try args.expectedOption("option"))
        XCTAssertThrowsError(try args.expectedArgument("file"))
        XCTAssertEqual(args.argument("file", default: "xxx"), "xxx")
    }

    func testArgument() {
        let args = Arguments(documentation: docs, version: "1.0", arguments: ["test", "blah"])
        XCTAssertEqual(args.argument("file"), "blah")
        XCTAssertEqual(args.argument("file", default: "foo"), "blah")
    }

    func testFlag() {
        let args = Arguments(documentation: docs, version: "1.0", arguments: ["test", "--flag"])
        XCTAssertEqual(args.flag("flag"), true)
    }

    func testOption() {
        let args = Arguments(documentation: docs, version: "1.0", arguments: ["test", "--option=blah"])
        XCTAssertEqual(args.option("option"), "blah")
        XCTAssertEqual(args.option("option", default: "test"), "blah")
    }
    
    func testCommand() {
        let args = Arguments(documentation: docs, version: "1.0", arguments: ["test", "wibble", "file"])
        XCTAssertTrue(args.command("wibble"))
        XCTAssertFalse(args.command("wobble"))
    }
}
