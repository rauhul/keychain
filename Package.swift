// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Keychain",
    products: [
        .library(name: "Keychain", targets: ["Keychain"])
    ],
    targets: [
        .target(name: "Keychain", dependencies: []),
        .testTarget(name: "KeychainTests", dependencies: ["Keychain"])
    ]
)
