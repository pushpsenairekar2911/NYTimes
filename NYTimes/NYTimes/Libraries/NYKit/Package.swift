// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NYKit",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NYKit",
            targets: ["NYKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dmytro-anokhin/url-image", from: "3.0.0"),
        .package(url: "https://github.com/markiv/SwiftUI-Shimmer", from: "1.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NYKit",
            dependencies: [.product(name: "URLImage", package: "url-image"),
                           .product(name: "Shimmer", package: "SwiftUI-Shimmer")],
            path: "Sources",
            resources: []),
        .testTarget(
            name: "NYKitTests",
            dependencies: ["NYKit"]),
    ]
)
