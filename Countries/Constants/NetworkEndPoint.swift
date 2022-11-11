//
//  NetworkEndPoint.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import Foundation

fileprivate struct Urls {
    static let countries = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries"
    static let countriesDetail = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/"
}
enum NetworkEndPoint {
    case countries
    case countriesDetail (code: String)
    func getURL() -> URL? {
        switch self {
        case .countriesDetail (let code):
            return URL(string: Urls.countriesDetail + code)
        case .countries:
            return URL(string: Urls.countries)
        }
    }
}

