// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "SwiftPackageScripts",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SwiftPackageScripts",
            targets: ["SwiftPackageScripts"]
        )
    ],
    targets: [
        .target(
            name: "SwiftPackageScripts",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SwiftPackageScriptsTests",
            dependencies: ["SwiftPackageScripts"]
        )
    ]
)
