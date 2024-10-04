// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftPackageScripts",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v16),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwiftPackageScripts",
            targets: ["SwiftPackageScripts"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftPackageScripts"),
        .testTarget(
            name: "SwiftPackageScriptsTests",
            dependencies: ["SwiftPackageScripts"]
        )
    ]
)
