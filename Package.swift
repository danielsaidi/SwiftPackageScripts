// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftPackageBuildScripts",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v16),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwiftPackageBuildScripts",
            targets: ["SwiftPackageBuildScripts"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftPackageBuildScripts"),
        .testTarget(
            name: "SwiftPackageBuildScriptsTests",
            dependencies: ["SwiftPackageBuildScripts"]
        ),
    ]
)
