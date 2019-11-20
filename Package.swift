// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SDL2Image",
    products: [
        .library(
            name: "SDL2Image",
            targets: ["SDL2Image"])
    ],
    targets: [
        .target(
            name: "SDL2Image",
            dependencies: ["CSDL2Image"]),
        .systemLibrary(name: "CSDL2Image",
                       path: "Sources/CSDL2Image",
                       pkgConfig: "SDL2_image",
                       providers: [
                        .brew(["SDL2_image"]),
                        .apt(["libsdl2-image-dev"])
        ]),
        .testTarget(
            name: "SDL2ImageTests",
            dependencies: ["SDL2Image"]),
    ]
)
