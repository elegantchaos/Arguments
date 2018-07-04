// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Created by Sam Deane, 07/03/2018.
// All code (c) 2018 - present day, Elegant Chaos Limited.
// For licensing terms, see http://elegantchaos.com/license/liberal/.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/**
Argument parsing.
Uses Docopt for the heavy lifting, but performs a bit of preliminary
cleanup first, and provides a simplified API to read options and arguments.
*/

import Docopt
import Logger

public struct Arguments {

    public enum Failure : Error {
    case unknownOption(name : String)
    }

    let program : String
    private var parsed : [String:Any]


    /**
    Parse the command line arguments.

    Any recognised options are pulled out into the options dictionary.
    Other arguments end up in the unused array (so that they can be passed on to a sub-process, for example).
    */

    public init(documentation : String, version: String) {
        let filteredArguments = Manager.removeLoggingOptions(from: CommandLine.arguments)
        self.program = filteredArguments[0]
        self.parsed = Docopt.parse(documentation, argv: Array(filteredArguments[1...]), help: true, version: version)
    }


    /**
    Return an option.
    It's an error to try to read an option that wasn't passed in when
    we were set up.
    */

    public func option(_ name : String) throws -> String  {
        if let value = parsed["--\(name)"] as? String {
            return value
        }

        throw Failure.unknownOption(name: name)
    }

    /**
    Return an option, or a default value if it's missing.
    */

    public func option(_ name : String, `default`: String) -> String  {
        if let value = parsed["--\(name)"] as? String {
            return value
        }
        return `default`
    }

    /**
    Check a boolean option.
    */

    public func option(_ name : String) -> Bool  {
        if let value = parsed["--\(name)"] as? Bool {
            return value
        }
        return false
    }

    /**
    Return an argument, or a default value if it's missing.
    */

    public func argument(_ name : String, `default`: String = "") -> String  {
        if let value = parsed["<\(name)>"] as? String {
            return value
        }
        return `default`
    }

    /**
    Was a particular command given?
    */

    public func command(_ name: String) -> Bool {
        if let value = parsed[name] as? Bool {
            return value
        }
        return false
    }

    /// MARK: Testing support.

    /**
    Init with an explicit program name and set of parsed arguments.

    This is intended for testing, where it's useful to be able to mock
    the arguments.
    */

    public init(program: String, parsed : [String:Any] = [:]) {
        self.program = program
        self.parsed = parsed
    }

    /**
    Set an option.
    Generally just used for testing, but can also be used to modify options
    during the course of execution.
    */

    public mutating func setOption(_ name: String, value: Any) {
        parsed["--\(name)"] = value
    }

    /**
    Set an argument.
    Generally just useful for testing.
    */

    public mutating func setArgument(_ name: String, value: Any) {
        parsed["<\(name)>"] = value
    }

    /**
    Set a command.
    Generally just useful for testing.
    */

    public mutating func setCommand(_ name: String) {
        parsed[name] = true
    }

    /**
    Clear a command.
    Generally just useful for testing.
    */

    public mutating func clearCommand(_ name: String) {
        parsed[name] = false
    }
}
