//
//  RandomDogViewModel.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

protocol RandomDogProtocol: AnyObject {
    func imageDownloaded(image: UIImage)
}

class RandomDogViewModel {

    weak var delegate: RandomDogProtocol?

    func fetchRandomDog() {
      let resource = RandomDogResource()
      let request = APIRequest(resource: resource)
        request.execute { result in
            switch result {
            case .success(let result):
                if let result = result, let message = result.message {
                    self.fetchImage(imageUrl: message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchImage(imageUrl: String) {
        let resource = DataResource(url: imageUrl)
        let request = DataRequest(resource: resource)
        request.execute { result in
            switch result {
            case .success(let result):
                if let result = result {
                    if let image = UIImage(data: result) {
                        self.delegate?.imageDownloaded(image: image)
                        ImageManager.shared.cacheImage(image: image)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getAllImages() -> [UIImage] {
        return ImageManager.shared.getAllDogsImagesFromCache().reversed()
    }
    func clearAllDogs() {
        ImageManager.shared.clearAll()
    }

}
