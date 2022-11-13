//
//  CountryDetailResponseModel.swift
//  Countries
//
//  Created by Kaan Turan on 11.11.2022.
//

import Foundation
struct CountryDetailResponseModel: Codable {
    let data: CountryDetailModel?
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct CountryDetailModel: Codable {
    let capital: String?
    let code: String
    let callingCode: String
    let currencyCodes: [String]
    let flagUrl: String
    let wikiDataId: String
    let name: String
    let numRegions: Int
    
    enum CodingKeys: String, CodingKey {
        case capital
        case code
        case callingCode
        case currencyCodes
        case flagUrl = "flagImageUri"
        case wikiDataId
        case name
        case numRegions
    }
    
    func getWikiUrl() -> URL? {
        let path = Constant.wikiDataURL + wikiDataId
        return URL(string: path)
    }
}
