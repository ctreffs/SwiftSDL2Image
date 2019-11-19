// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSDLImage",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftSDLImage",
            targets: ["SwiftSDLImage"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
       
        .target(
            name: "SwiftSDLImage",
            dependencies: ["CSDLImage"]),
        .systemLibrary(name: "CSDLImage",
                              path: "Sources/CSDLImage",
                              pkgConfig: "SDL_image",
                              providers: [
                                   .brew(["SDL_Image"])
                               ]),
        
        .testTarget(
            name: "SwiftSDLImageTests",
            dependencies: ["SwiftSDLImage"]),
    ]
)
