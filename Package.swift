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
    dependencies: [

        .package(url: "https://github.com/swift-atoms/swift-comparison.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-equation.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-hash.git", branch: "main"),

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
                .product(name: "Hash", package: "swift-hash"),
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
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Difference", package: "swift-difference"),
                .target(name: "Ordinal Test Support"),
                .target(name: "Ordinal Foundation Integration"),
            ],
            path: "Tests/Ordinal Tests"
        ),
        .testTarget(
            name: "Consolidated Ordinal Comparison Tests",
            dependencies: [

                .target(name: "Ordinal"),
                .product(name: "Comparison", package: "swift-comparison"),
            ],
            path: "Tests/Consolidated swift-ordinal-comparison"
        ),
        .testTarget(
            name: "Consolidated Ordinal Equation Tests",
            dependencies: [

                .target(name: "Ordinal"),
                .product(name: "Equation", package: "swift-equation"),
            ],
            path: "Tests/Consolidated swift-ordinal-equation"
        ),
        .testTarget(
            name: "Consolidated Ordinal Hash Tests",
            dependencies: [

                .target(name: "Ordinal"),
                .product(name: "Hash", package: "swift-hash"),
            ],
            path: "Tests/Consolidated swift-ordinal-hash"
        ),
        .testTarget(
            name: "Consolidated Ordinal Property Tests",
            dependencies: [

                .target(name: "Ordinal"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
            ],
            path: "Tests/Consolidated swift-ordinal-property"
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
