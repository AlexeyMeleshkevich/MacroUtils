// swift-tools-version: 5.9
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "MacroUtils",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "MacroUtils",
            targets: ["MacroUtils"]
        ),
        .executable(
            name: "MacroUtilsClient",
            targets: ["MacroUtilsClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    ],
    targets: [
        .macro(
            name: "URLValidationMacro",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        .target(name: "MacroUtils", dependencies: ["URLValidationMacro"]),

        .executableTarget(name: "MacroUtilsClient", dependencies: ["MacroUtils"]),

        .testTarget(
            name: "MacroUtilsTests",
            dependencies: [
                "URLValidationMacro",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
