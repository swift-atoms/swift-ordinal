// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-ordinal",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Ordinal",
            targets: ["Ordinal"]
        ),
        .library(
            name: "Ordinal Standard Library Integration",
            targets: ["Ordinal Standard Library Integration"]
        ),
        .library(
            name: "Ordinal Apple Foundation Integration",
            targets: ["Ordinal Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Ordinal",
            dependencies: []
        ),
        .target(
            name: "Ordinal Standard Library Integration",
            dependencies: [
                "Ordinal"
            ]
        ),
        .target(
            name: "Ordinal Apple Foundation Integration",
            dependencies: [
                "Ordinal",
                "Ordinal Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Ordinal Tests",
            dependencies: [
                "Ordinal"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = [
        .define(
            "SYNCHRONIZATION_AVAILABLE",
            .when(platforms: [.macOS, .iOS, .tvOS, .watchOS, .visionOS, .linux, .windows])
        )
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
