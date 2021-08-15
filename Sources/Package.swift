// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Stinsen",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v7)],
    products: [
        .library(
            name: "Stinsen",
            targets: ["Stinsen"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Stinsen",
            dependencies: [],
            path: "Stinsen"
	),
    ]
)
