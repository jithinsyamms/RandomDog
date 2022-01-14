//
//  ImageManager.swift
//  RandomDog
//
//  Created by Jithin on 15/01/22.
//

import UIKit

class ImageManager {

    static let maxImageCount = 5
    static let shared = ImageManager()
    private var imageCache: ImageCache
    private var coreData: CoreDataManager
    private init() {
        imageCache = ImageCache()
        coreData = CoreDataManager()
        setUpCacheFromDB()
    }

    func setUpCacheFromDB() {
        let randomDogs = coreData.getAllDogs()
        for dog in randomDogs {
            if let key = dog.key, let data = dog.dogImage, let image = UIImage(data: data) {
                let keyString = NSString(string: key)
                imageCache.cacheImage(key: keyString, image: image)
            }
        }
    }

    func getAllDogsImagesFromCache() -> [UIImage] {
        return imageCache.getAllImages()
    }

    func cacheImage(image: UIImage) {
        removeOldestIfCacheIsFull()
        let dateString = "\(Date().timeIntervalSince1970 * 1000)"
        let timeInMillis = NSString(string: dateString)
        imageCache.cacheImage(key: timeInMillis, image: image)
        coreData.addDog(key: timeInMillis, image: image)
    }

    func clearAll() {
        imageCache.clearCache()
        coreData.deleteAllDogs()
    }

    func removeOldestIfCacheIsFull() {
        if  imageCache.getCacheSize() >= ImageManager.maxImageCount {
            print("Cache is Full Removing Item")
            let key = imageCache.removeOldestImage()
            coreData.deleteDog(key: key)
        }
    }
}
