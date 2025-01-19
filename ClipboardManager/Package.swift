// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ClipboardManager",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .app(
            name: "ClipboardManager",
            targets: ["ClipboardManagerApp"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ClipboardManagerApp",
            dependencies: [],
            path: "Sources/App"
        ),
        .target(
            name: "Core",
            dependencies: [],
            path: "Sources/Core"
        ),
        .testTarget(
            name: "UnitTests",
            dependencies: ["ClipboardManagerApp"],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "UITests",
            dependencies: ["ClipboardManagerApp"],
            path: "Tests/UITests"
        )
    ]
)