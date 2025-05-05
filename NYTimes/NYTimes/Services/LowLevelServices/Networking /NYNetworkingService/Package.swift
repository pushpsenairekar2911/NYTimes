// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NYNetworkingService",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NYNetworkingService",
            targets: ["NYNetworkingService"]),
    ],
    dependencies: [],
    targets: [.target(
        name: "NYNetworkingService",
        dependencies: [],
        path: "Sources"),
    ]
)
