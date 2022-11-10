//
//  NetworkEndPoint.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import Foundation

enum NetworkEndPoint: String {
    case countries = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries"
    case countriesDetail = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/code"
    func getURL() -> URL? {
        let url = URL(string: self.rawValue)
        return url
    }
}

