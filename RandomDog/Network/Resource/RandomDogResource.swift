//
//  RandomDogResource.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import Foundation

struct RandomDogResource: APIResource {

    typealias Response = RandomDogModel
    var urlString: String {
        "https://dog.ceo/api/breeds/image/random"
    }
}
