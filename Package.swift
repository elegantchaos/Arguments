// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Arguments",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Arguments",
            targets: ["Arguments"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/Logger", from: "1.0.8"),
        .package(url: "https://github.com/elegantchaos/docopt.swift", from: "0.6.8"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Arguments",
            dependencies: ["Docopt", "Logger"]),
        .testTarget(
            name: "ArgumentsTests",
            dependencies: ["Arguments"]),
    ]
)
