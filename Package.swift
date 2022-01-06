// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActivityView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ActivityView",
            targets: ["ActivityView"]),
    ],
    targets: [
        .target(
            name: "ActivityView",
            dependencies: []),
    ]
)
