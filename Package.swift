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
            name: "Ordinal Primitive",
            targets: ["Ordinal Primitive"]
        ),

        .library(
            name: "Ordinal Error",
            targets: ["Ordinal Error"]
        ),
        .library(
            name: "Ordinal Protocol",
            targets: ["Ordinal Protocol"]
        ),
        .library(
            name: "Ordinal Advance",
            targets: ["Ordinal Advance"]
        ),
        .library(
            name: "Ordinal Retreat",
            targets: ["Ordinal Retreat"]
        ),
        .library(
            name: "Ordinal Successor",
            targets: ["Ordinal Successor"]
        ),
        .library(
            name: "Ordinal Predecessor",
            targets: ["Ordinal Predecessor"]
        ),
        .library(
            name: "Ordinal Distance",
            targets: ["Ordinal Distance"]
        ),
        .library(
            name: "Ordinal Cardinal",
            targets: ["Ordinal Cardinal"]
        ),
        .library(
            name: "Ordinal Carrier",
            targets: ["Ordinal Carrier"]
        ),
        .library(
            name: "Ordinal Equation",
            targets: ["Ordinal Equation"]
        ),
        .library(
            name: "Ordinal Hash",
            targets: ["Ordinal Hash"]
        ),
        .library(
            name: "Ordinal Comparison",
            targets: ["Ordinal Comparison"]
        ),
        .library(
            name: "Ordinal Tagged",
            targets: ["Ordinal Tagged"]
        ),

        .library(
            name: "Ordinal Standard Library Integration",
            targets: ["Ordinal Standard Library Integration"]
        ),

        .library(
            name: "Ordinal",
            targets: ["Ordinal"]
        ),

        .library(
            name: "Ordinal Test Support",
            targets: ["Ordinal Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-carrier.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Ordinal Primitive",
            dependencies: []
        ),

        .target(
            name: "Ordinal Error",
            dependencies: [
                "Ordinal Primitive"
            ]
        ),
        .target(
            name: "Ordinal Protocol",
            dependencies: [
                "Ordinal Primitive",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Advance",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Error",
                "Ordinal Protocol",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Retreat",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Error",
                "Ordinal Protocol",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Successor",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Error",
                "Ordinal Protocol",
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Predecessor",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Error",
                "Ordinal Protocol",
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Distance",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Error",
                "Ordinal Protocol",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Cardinal",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Protocol",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Carrier", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Ordinal Carrier",
            dependencies: [
                "Ordinal Primitive",
                .product(name: "Carrier", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Ordinal Equation",
            dependencies: [
                "Ordinal Primitive",
                .product(name: "Equation", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Ordinal Hash",
            dependencies: [
                "Ordinal Primitive",
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Ordinal Comparison",
            dependencies: [
                "Ordinal Primitive",
                .product(name: "Comparison", package: "swift-comparison"),
            ]
        ),
        .target(
            name: "Ordinal Tagged",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Cardinal",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),

        .target(
            name: "Ordinal Standard Library Integration",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Error",
                "Ordinal Protocol",
                "Ordinal Cardinal",
                "Ordinal Distance",
                "Ordinal Tagged",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(
                    name: "Cardinal Standard Library Integration",
                    package: "swift-cardinal"
                ),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
            ]
        ),

        .target(
            name: "Ordinal",
            dependencies: [
                "Ordinal Primitive",
                "Ordinal Error",
                "Ordinal Protocol",
                "Ordinal Advance",
                "Ordinal Retreat",
                "Ordinal Successor",
                "Ordinal Predecessor",
                "Ordinal Distance",
                "Ordinal Cardinal",
                "Ordinal Carrier",
                "Ordinal Equation",
                "Ordinal Hash",
                "Ordinal Comparison",
                "Ordinal Tagged",
                "Ordinal Standard Library Integration",
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),

        .target(
            name: "Ordinal Test Support",
            dependencies: [
                "Ordinal",
                .product(
                    name: "Cardinal Test Support",
                    package: "swift-cardinal"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Ordinal Tests",
            dependencies: [
                "Ordinal",
                "Ordinal Standard Library Integration",
                "Ordinal Test Support",
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
