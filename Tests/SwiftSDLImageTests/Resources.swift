//
//  Resource.swift
//
//
//  Created by Christian Treffs on 21.06.19.
//

import Foundation

enum Resource: String {
    case logo_png = "https://raw.githubusercontent.com/fireblade-engine/media/master/media/Logo.png"

    enum Error: Swift.Error {
        case invalidURL(String)
    }

    static func resourcesDir() -> URL {
        #if os(Linux)
        // linux does not have .allBundles yet.
        let bundle = Bundle.main
        #else
        guard let bundle = Bundle.allBundles.first(where: { $0.bundlePath.contains("Tests") }) else {
            fatalError("no test bundle found")
        }
        #endif
        var resourcesURL: URL = bundle.bundleURL
        resourcesURL.deleteLastPathComponent()
        return resourcesURL
    }
    static func load(_ resource: Resource) throws -> URL {
        guard let remoteURL: URL = URL(string: resource.rawValue) else {
            throw Error.invalidURL(resource.rawValue)
        }

        var name: String = remoteURL.pathComponents.reversed().prefix(3).reversed().joined(separator: "_")
        name.append(".")
        name.append(remoteURL.lastPathComponent)

        let localFile: URL = resourcesDir().appendingPathComponent(name)
        if !FileManager.default.fileExists(atPath: localFile.path) {
            let data = try Data(contentsOf: remoteURL)
            try data.write(to: localFile)
            print("⬇ Downloaded '\(localFile.path)' ⬇")
        }

        return localFile
    }
}
