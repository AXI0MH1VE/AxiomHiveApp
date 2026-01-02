// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AxiomHiveApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AxiomHiveApp",
            targets: ["AxiomHiveApp"]
        )
    ],
    dependencies: [
        // No external dependencies - using only native iOS frameworks
    ],
    targets: [
        .target(
            name: "AxiomHiveApp",
            dependencies: [],
            path: "AxiomHiveApp"
        ),
        .testTarget(
            name: "AxiomHiveAppTests",
            dependencies: ["AxiomHiveApp"],
            path: "AxiomHiveAppTests"
        )
    ]
)
