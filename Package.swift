// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "swift-kenall",
    products: [
        .library(
            name: "Kenall",
            targets: ["Kenall"]
        ),
        .executable(
            name: "kenall-cli",
            targets: ["KenallCli"]
        ),
    ],
    targets: [
        .target(
            name: "Kenall",
            dependencies: []
        ),
        .target(
            name: "KenallCli",
            dependencies: ["Kenall"]
        ),
        .testTarget(
            name: "KenallTests",
            dependencies: ["Kenall"]
        ),
    ]
)
