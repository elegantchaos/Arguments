// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Arguments",
    products: [
        .library(
            name: "Arguments",
            targets: ["Arguments"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/docopt.swift.git", from: "0.6.11")
    ],
    targets: [
        .target(
            name: "Arguments",
            dependencies: ["Docopt"]),
        .testTarget(
            name: "ArgumentsTests",
            dependencies: ["Arguments"]),
    ]
)
