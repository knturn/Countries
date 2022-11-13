//
//  Constant.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import UIKit.UIViewController
struct Constant {
    static let apiKey = "5acac95d4bmsh850fc600988bfacp1f4b80jsnf445a5ce0b63"
    static let hostString = "wft-geo-db.p.rapidapi.com"
    static let savedCountryKeyUD = "savedCountries"
    static let wikiDataURL = "https://www.wikidata.org/wiki/"
}

typealias Countries = [CountryModel]
typealias ConfigureToTableView = UITableViewDelegate & UITableViewDataSource
typealias Country = (name: String, code: String)


enum CurrentFavState {
    case saved
    case notSaved
    var image: UIImage? {
        switch self {
        case .saved:
            return UIImage(systemName: "star.fill")
        case .notSaved:
            return UIImage(systemName: "star")
        }
    }
}

