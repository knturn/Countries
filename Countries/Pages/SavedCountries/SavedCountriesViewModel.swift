//
//  SavedCountriesViewModel.swift
//  Countries
//
//  Created by Kaan Turan on 13.11.2022.
//

import Foundation

class SavedCountriesViewModel {
    var savedCountries = [Country]()
    init() {
        updateSavedCountries()
    }
}

extension SavedCountriesViewModel {
    func updateSavedCountries() {
        self.savedCountries = StorageManager.shared.getAllSavedCountries()
    }
    
    func getCountriesCount() -> Int {
        savedCountries.count
    }
    
    func getCountryTuple(indexpath: IndexPath) -> Country {
        return savedCountries[indexpath.row]
    }
}

