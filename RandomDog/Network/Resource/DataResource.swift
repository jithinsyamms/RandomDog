//
//  DataResource.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import Foundation

struct DataResource: APIResource {

    typealias Response = Data?

    var dataUrl:String
    init(url:String) {
        dataUrl = url
    }
    var urlString: String {
       dataUrl
    }
}

