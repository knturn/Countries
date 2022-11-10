//
//  NetworkService.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import Foundation

final class NetworkService {
    static let shared: NetworkService = NetworkService()
}
extension NetworkService {
    func fetch<T>(request: URLRequest, onSuccess:  @escaping (T) -> Void, onError: @escaping (Error) -> Void) where T: Codable {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  error == nil
            else {
                onError(NetworkServiceErrors.fetchFailed)
                return
            }
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(T.self, from: data) {
                onSuccess(model)
            }
            else {
                onError(NetworkServiceErrors.parseFailed)
            }
        } .resume()
    }
}
public enum NetworkServiceErrors: Error {
    case fetchFailed
    case parseFailed
}



