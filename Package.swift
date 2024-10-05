// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "ScrollKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "ScrollKit",
            targets: ["ScrollKit"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ScrollKit",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "ScrollKitTests",
            dependencies: ["ScrollKit"]
        )
    ]
)
