//
//  ImageTests.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/13/25.
//

@testable @preconcurrency import ourRecipes
import XCTest

final class ImageTests: XCTestCase {

    func testLoadCachedImage() async {
        let validURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/903015fb-7bc2-426b-aa1b-724d0007ce30/small.jpg")!
        let image = await ImageHelper.loadCachedImage(from: validURL)
        XCTAssertNotNil(image, "Image should not be nil!")

    }
    
    func testLoadCachedImageInvalidURL() async {
        let invalidURL = URL(string: "invalidURLafhsakjfh")!
        let image = await ImageHelper.loadCachedImage(from: invalidURL)
        XCTAssertNil(image, "Image should be nil!")

    }
    
    func testLoadCachedImageUncached() async {
        let validURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/903015fb-7bc2-426b-aa1b-724d0007ce30/small.jpg")!
        
        // ensure image is not cached
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cachePath = cacheDir.appendingPathComponent(validURL.absoluteString.replacingOccurrences(of: "/", with: "_"))
        try? FileManager.default.removeItem(at: cachePath)
        
        let image = await ImageHelper.loadCachedImage(from: validURL)
        
        // Assert that the image is not nil (it should be downloaded)
        XCTAssertNotNil(image, "Image should be downloaded and cached.")


    }
   

}
