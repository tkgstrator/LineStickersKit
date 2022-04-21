// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LineStickersKit",
    platforms: [
       .macOS(.v11), .iOS(.v14), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LineStickersKit",
            targets: ["LineStickersKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.2"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.5.0"),
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", from: "2.4.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LineStickersKit",
            dependencies: ["Alamofire", "SDWebImageSwiftUI", "ZipArchive"]),
        .testTarget(
            name: "LineStickersKitTests",
            dependencies: ["LineStickersKit"]),
    ]
)
