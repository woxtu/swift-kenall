// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "swift-kenall",
    products: [
        .library(
            name: "Kenall",
            targets: ["Kenall"]),
    ],
    targets: [
        .target(
            name: "Kenall",
            dependencies: []),
        .testTarget(
            name: "KenallTests",
            dependencies: ["Kenall"]),
    ]
)

