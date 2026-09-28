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
        .library(name: "Ordinal", targets: ["Ordinal"]),

        .library(name: "Ordinal Foundation Integration", targets: ["Ordinal Foundation Integration"]),
        .library(name: "Ordinal Test Support", targets: ["Ordinal Test Support"]),
    ],
    traits: [
        .trait(name: "Tagged", description: "Tagged integration"),
    ],
    dependencies: [


        .package(
            url: "https://github.com/swift-atoms/swift-magnitude.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-carrier.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-difference.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-successor.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-predecessor.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-advancement.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-retreat.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-distance.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Ordinal",
            dependencies: [
                .product(name: "Magnitude", package: "swift-magnitude", condition: .when(traits: ["Tagged"])),
                .product(name: "Advancement", package: "swift-advancement", condition: .when(traits: ["Tagged"])),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier", condition: .when(traits: ["Tagged"])),
                .product(name: "Difference", package: "swift-difference", condition: .when(traits: ["Tagged"])),
                .product(name: "Distance", package: "swift-distance", condition: .when(traits: ["Tagged"])),
                .product(name: "Predecessor", package: "swift-predecessor", condition: .when(traits: ["Tagged"])),
                .product(name: "Property", package: "swift-property", condition: .when(traits: ["Tagged"])),
                .product(name: "Retreat", package: "swift-retreat", condition: .when(traits: ["Tagged"])),
                .product(name: "Successor", package: "swift-successor", condition: .when(traits: ["Tagged"])),
                .product(name: "Tagged", package: "swift-tagged", condition: .when(traits: ["Tagged"])),
            ],
            path: "Sources/Ordinal"
        ),
        
        .target(
            name: "Ordinal Foundation Integration",
            dependencies: [
                .target(name: "Ordinal"),
            ],
            path: "Sources/Ordinal Foundation Integration"
        ),
        .target(
            name: "Ordinal Test Support",
            dependencies: [
                .target(name: "Ordinal"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Ordinal Tests",
            dependencies: [
                .target(name: "Ordinal"),
                .product(name: "Tagged", package: "swift-tagged", condition: .when(traits: ["Tagged"])),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Difference", package: "swift-difference", condition: .when(traits: ["Tagged"])),
                .target(name: "Ordinal Test Support"),
                .target(name: "Ordinal Foundation Integration"),
            ],
            path: "Tests/Ordinal Tests"
        ),
        .testTarget(
            name: "Consolidated Ordinal Property Tests",
            dependencies: [

                .target(name: "Ordinal"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier", condition: .when(traits: ["Tagged"])),
                .product(name: "Property", package: "swift-property", condition: .when(traits: ["Tagged"])),
            ],
            path: "Tests/Consolidated swift-ordinal-property"
        ),
        .testTarget(name: "Ordinal Difference Carrier Migration Tests", dependencies: [
            .target(name: "Ordinal"),
            .product(name: "Difference", package: "swift-difference", condition: .when(traits: ["Tagged"])),
            .product(name: "Cardinal", package: "swift-cardinal"),
            .product(name: "Carrier", package: "swift-carrier", condition: .when(traits: ["Tagged"])),
            .product(name: "Tagged", package: "swift-tagged", condition: .when(traits: ["Tagged"])),
        ], path: "Tests/Ordinal Difference Carrier Migration Tests"),
        .testTarget(name: "Ordinal Tagged Pointer Migration Tests", dependencies: [
            .target(name: "Ordinal"),
            .product(name: "Difference", package: "swift-difference", condition: .when(traits: ["Tagged"])),
            .product(name: "Tagged", package: "swift-tagged", condition: .when(traits: ["Tagged"])),
        ], path: "Tests/Ordinal Tagged Pointer Migration Tests"),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .define("SYNCHRONIZATION_AVAILABLE", .when(platforms: [.macOS, .iOS, .tvOS, .watchOS, .visionOS, .linux, .windows])),
    ]
}
