// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ScrollKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "ScrollKit",
            targets: ["ScrollKit"])
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
