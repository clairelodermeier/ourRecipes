//
//  ImageHelper.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/13/25.
//
import Foundation
import UIKit

struct ImageHelper {
    static func loadCachedImage(from url: URL) async -> UIImage? {
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

        // Create cache path
        let cachePath = cacheDir.appendingPathComponent(url.absoluteString.replacingOccurrences(of: "/", with: "_")
)

        // Check for cached image
        if let image = UIImage(contentsOfFile: cachePath.path) {
            return image
        }

        // Download and cache the image
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try data.write(to: cachePath)
            return UIImage(data: data)
        } catch {
            print("Error loading image", error)
            return nil
        }
    }
}
