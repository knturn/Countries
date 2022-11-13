//
//  StorageManager.swift
//  Countries
//
//  Created by Kaan Turan on 11.11.2022.
//

import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    private let userDefaults = UserDefaults.standard
    
    func saveCountry(country: Country) {
        var savedCountries = getSavedCountries()
        savedCountries.append([country.code: country.name])
        setSavedCountries(array: savedCountries)
    }
    
    func removeCountry(country: Country) {
        var savedCountries = getSavedCountries()
        savedCountries.removeAll { element in
            return element[country.code] != nil
        }
        setSavedCountries(array: savedCountries)
    }
    
    func checkCountry(code: String) -> Bool {
        let savedCountries = getSavedCountries()
        let isSaved = savedCountries.contains { element in
            element[code] != nil
        }
        return isSaved
    }
    
    func getAllSavedCountries() -> [Country] {
        let countriesArray = getSavedCountries()
        let country = countriesArray.compactMap { element -> Country? in
            guard let code = element.keys.first,
                  let name = element.values.first else {return nil}
            return Country(name: name, code: code)
        }
        return country
    }
    
    private func getSavedCountries() -> [Dictionary<String,String>]  {
        let array =  userDefaults.value(forKey: Constant.savedCountryKeyUD) as? [Dictionary<String,String>] ?? []
        return array
        
    }
    private func setSavedCountries(array: [Dictionary<String,String>]) {
        userDefaults.set(array, forKey: Constant.savedCountryKeyUD)
    }
}
