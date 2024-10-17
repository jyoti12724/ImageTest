//
//  ImageCache.swift
//  TestSwiftUi
//
//  Created by Jyoti Gupta on 15/10/24.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSURL, UIImage>()
    
    func getImage(for url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }
    
    func saveImage(_ image: UIImage, for url: NSURL) {
        cache.setObject(image, forKey: url)
    }
}
