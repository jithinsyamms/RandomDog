//
//  ImageCache.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

class ImageCache {

    var cacheKeys: [NSString]
    var cache: NSCache<NSString, UIImage>

    init() {
        cacheKeys = []
        cache = NSCache<NSString, UIImage>()
        cache.countLimit = 0
        cache.name = "ImageCache"
    }

    func getAllImages() -> [UIImage] {
        var allImages: [UIImage] = []
        for key in cacheKeys {
            if let image = cache.object(forKey: key) {
                allImages.append(image)
            }
        }
        return allImages
    }

    func cacheImage(key: NSString, image: UIImage) {
        cacheKeys.append(key)
        cache.setObject(image, forKey: key)
    }

    func clearCache() {
        cacheKeys.removeAll()
        cache.removeAllObjects()
    }

    func getCacheSize() -> Int {
        return cacheKeys.count
    }

    func removeOldestImage() -> NSString {
        let key = cacheKeys.removeFirst()
        cache.removeObject(forKey: key)
        return key
    }
}
