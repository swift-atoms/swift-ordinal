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
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Ordinal",
            dependencies: []
        ),

        .target(
            name: "Ordinal Error",
            dependencies: [
                .target(name: "Ordinal")
            ]
        ),
        .target(
            name: "Ordinal Protocol",
            dependencies: [
                .target(name: "Ordinal"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Carrier", package: "swift-cardinal"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Advance",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Error"),
                .target(name: "Ordinal Protocol"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Carrier", package: "swift-cardinal"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Retreat",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Error"),
                .target(name: "Ordinal Protocol"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Successor",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Error"),
                .target(name: "Ordinal Protocol"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Predecessor",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Error"),
                .target(name: "Ordinal Protocol"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Distance",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Error"),
                .target(name: "Ordinal Protocol"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Carrier", package: "swift-cardinal"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Ordinal Cardinal",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Protocol"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Carrier", package: "swift-cardinal"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Ordinal Carrier",
            dependencies: [
                .target(name: "Ordinal"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Ordinal Equation",
            dependencies: [
                .target(name: "Ordinal"),
                .product(name: "Equation Protocol", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Ordinal Hash",
            dependencies: [
                .target(name: "Ordinal"),
                .product(name: "Hash Protocol", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Ordinal Comparison",
            dependencies: [
                .target(name: "Ordinal"),
                .product(name: "Comparison Protocol", package: "swift-comparison"),
            ]
        ),
        .target(
            name: "Ordinal Tagged",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Cardinal"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),

        .target(
            name: "Ordinal Standard Library Integration",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Error"),
                .target(name: "Ordinal Protocol"),
                .target(name: "Ordinal Cardinal"),
                .target(name: "Ordinal Distance"),
                .target(name: "Ordinal Tagged"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(
                    name: "Cardinal Standard Library Integration",
                    package: "swift-cardinal"
                ),
                .product(name: "Cardinal Carrier", package: "swift-cardinal"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
            ]
        ),

        .target(
            name: "Ordinal Test Support",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Advance"),
                .target(name: "Ordinal Retreat"),
                .target(name: "Ordinal Successor"),
                .target(name: "Ordinal Predecessor"),
                .target(name: "Ordinal Distance"),
                .target(name: "Ordinal Cardinal"),
                .target(name: "Ordinal Equation"),
                .target(name: "Ordinal Comparison"),
                .target(name: "Ordinal Tagged"),
                .target(name: "Ordinal Standard Library Integration"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Equation", package: "swift-cardinal"),
                .product(
                    name: "Cardinal Standard Library Integration",
                    package: "swift-cardinal"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Ordinal Tests",
            dependencies: [
                .target(name: "Ordinal"),
                .target(name: "Ordinal Standard Library Integration"),
                .target(name: "Ordinal Test Support"),
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
