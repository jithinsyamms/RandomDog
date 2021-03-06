//
//  NetworkRequest.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import Foundation

protocol NetworkRequest {
    associatedtype Model
    func decode(_ data: Data) -> Model?
    func execute(withCompletion completion: @escaping (Result<Model?, Error>) -> Void)
}

extension NetworkRequest {

    func load<Resource: APIResource>( resource: Resource,
                                      withCompletion completion: @escaping (Result<Model?, Error>) -> Void) {
        guard let url = resource.URL else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = resource.method
        for header in resource.headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
        }

        let task = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.serverError))
                return
            }
            guard let result = self.decode(data) else {
                completion(.failure(NetworkError.decodeError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(result))
            }
        }
        task.resume()
    }
}
