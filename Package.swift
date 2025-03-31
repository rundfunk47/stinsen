// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Stinsen",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Stinsen", targets: ["Stinsen"])
    ],
    targets: [
        .target(name: "Stinsen", path: "Sources")
    ]
)
