// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSDL2Image",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftSDL2Image",
            targets: ["SwiftSDL2Image"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
       
        .target(
            name: "SwiftSDL2Image",
            dependencies: ["CSDL2Image"]),
        .systemLibrary(name: "CSDL2Image",
                              path: "Sources/CSDL2Image",
                              pkgConfig: "SDL2_image",
                              providers: [
                                   .brew(["SDL2_image"]),
                                   .apt(["libsdl2-image-dev"])
                               ]),
        
        .testTarget(
            name: "SwiftSDL2ImageTests",
            dependencies: ["SwiftSDL2Image"]),
    ]
)
