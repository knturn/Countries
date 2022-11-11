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
    
    func saveCountry(code: String) {
        var savedCountries = getSavedCountries()
        savedCountries.insert(code)
        setSavedCountries(set: savedCountries)
    }
    
    func removeCountry(code: String) {
        var savedCountries = getSavedCountries()
        savedCountries.remove(code)
        setSavedCountries(set: savedCountries)
    }
    
    func checkCountry(code: String) -> Bool {
        let savedCountries = getSavedCountries()
        let isSaved = savedCountries.contains { element in
            element == code
        }
        return isSaved
    }
    
    private func getSavedCountries() -> Set<String>  {
        let array =  userDefaults.value(forKey: Constant.savedCountryKeyUD) as? Array<String> ?? []
        return Set(array)
        
    }
    private func setSavedCountries(set: Set<String>) {
        let array = Array(set)
        userDefaults.set(array, forKey: Constant.savedCountryKeyUD)
    }
}

