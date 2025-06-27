// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DylKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "DylKit", targets: ["DylKit"]),
        .library(name: "DylKitAPI", targets: ["DylKitAPI"]),
        .library(name: "DylKitNotes", targets: ["DylKitNotes"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Dyldog/HighlightedTextEditor", branch: "main"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.8.8")
    ],
    targets: [
        .target(
            name: "DylKit",
            dependencies: []),
        .target(
            name: "DylKitAPI",
            dependencies: ["DylKit", "SwiftSoup"]),
        .target(
            name: "DylKitNotes",
            dependencies: ["DylKit", "HighlightedTextEditor"]),
        .testTarget(
            name: "DylKitTests",
            dependencies: ["DylKit"]),
    ]
)
