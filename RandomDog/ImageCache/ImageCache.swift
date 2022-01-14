//
//  ImageCache.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

class ImageCache {

    static let shared = ImageCache()
    private init(){

    }
    lazy var imageCache: NSCache<NSNumber, UIImage> = {
       var cache = NSCache<NSNumber,UIImage>()
        cache.countLimit = 20
        cache.totalCostLimit = 20
        cache.name = "Image Cache"
        return cache
    }()

    var cacheKeys:[NSNumber] = []

    func cacheImage(image:UIImage) {
        let timeInMillis =  NSNumber(value: Date().timeIntervalSince1970 * 1000)
        cacheKeys.append(timeInMillis)
        imageCache.setObject(image, forKey: timeInMillis)
    }

    func clearCache() {
        imageCache.removeAllObjects()
    }

    func getAll() -> [UIImage] {
        var allImages:[UIImage] = []
        for key in cacheKeys {
            if let image = imageCache.object(forKey: key){
                allImages.append(image)
            }
        }
        return allImages
    }
}
