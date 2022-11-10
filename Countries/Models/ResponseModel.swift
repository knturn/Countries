//
//  CountryModel.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import Foundation
struct ResponseModel: Codable {
    let data: Countries?
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct CountryModel: Codable {
    let code: String?
    let name: String?
    let wikiDataId: String?
    let currencyCodes: Array<String>?
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
        case wikiDataId = "wikiDataId"
        case currencyCodes = "currencyCodes"
    }
    
}
