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
        .library(name: "Ordinal Standard Library Integration", targets: ["Ordinal Standard Library Integration"]),
        .library(name: "Ordinal Foundation Library Integration", targets: ["Ordinal Foundation Library Integration"]),
        .library(name: "Ordinal Test Support", targets: ["Ordinal Test Support"]),
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
                .product(name: "Magnitude", package: "swift-magnitude"),
                .product(name: "Advancement", package: "swift-advancement"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Difference", package: "swift-difference"),
                .product(name: "Distance", package: "swift-distance"),
                .product(name: "Predecessor", package: "swift-predecessor"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Retreat", package: "swift-retreat"),
                .product(name: "Successor", package: "swift-successor"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Sources/Ordinal"
        ),
        .target(
            name: "Ordinal Standard Library Integration",
            dependencies: [
                .target(name: "Ordinal"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Standard Library Integration", package: "swift-cardinal"),
                .product(name: "Difference", package: "swift-difference"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Sources/Ordinal Standard Library Integration"
        ),
        .target(
            name: "Ordinal Foundation Library Integration",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Standard Library Integration"),
            ],
            path: "Sources/Ordinal Foundation Library Integration"
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
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Tagged Standard Library Integration", package: "swift-tagged"),
                .target(name: "Ordinal Standard Library Integration"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Difference", package: "swift-difference"),
                .target(name: "Ordinal Test Support"),
                .target(name: "Ordinal Foundation Library Integration"),
            ],
            path: "Tests/Ordinal Tests"
        ),
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
