// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ScrollKit",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v7),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ScrollKit",
            targets: ["ScrollKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ScrollKit",
            dependencies: []),
        .testTarget(
            name: "ScrollKitTests",
            dependencies: ["ScrollKit"])
    ]
)
