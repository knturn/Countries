//
//  NetworkManager.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    func fetchCountries(limit: Int = 10, onSuccess: @escaping (Countries?) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = NetworkEndPoint.countries.getURL()
        else {
            onError(NetworkServiceErrors.fetchFailed)
            return
        }
        let parameters = [URLQueryItem(name: "limit", value: String(limit))]
        guard let request = url.createRequest(parameters: parameters) else {return}
        NetworkService.shared.fetch(request: request) { (response:CountriesResponseModel) in
            onSuccess(response.data)
        } onError: { error in
            print(error)
            onError(error)
        }
    }
    func fetchCountryDetail(code: String, onSuccess: @escaping (CountryDetailModel?) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = NetworkEndPoint.countriesDetail(code: code).getURL()
        else {
            onError(NetworkServiceErrors.fetchFailed)
            return
        }
        guard let request = url.createRequest() else {return}
        NetworkService.shared.fetch(request: request) { (response:CountryDetailResponseModel) in
            onSuccess(response.data)
        } onError: { error in
            print(error)
            onError(error)
        }
    }
}
