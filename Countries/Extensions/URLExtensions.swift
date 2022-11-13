//
//  URLExtensions.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import Foundation
extension URL {
    func createRequest(parameters: [URLQueryItem] = []) -> URLRequest? {
        let headers = [
            "X-RapidAPI-Key": Constant.apiKey,
            "X-RapidAPI-Host": Constant.hostString
        ]
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = parameters
        guard let url = components?.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
}
