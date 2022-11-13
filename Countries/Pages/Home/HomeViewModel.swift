//
//  HomeViewModel.swift
//  Countries
//
//  Created by Kaan Turan on 11.11.2022.
//

import Foundation

class HomeViewModel {
    var countriesArray = Countries()
    func fetchCountries(completion: @escaping (Result<Bool,Error>) -> Void) {
        NetworkManager.shared.fetchCountries { [weak self] countries in
            guard let self = self else {return}
            guard let countries = countries else {return}
            self.countriesArray = countries
            completion(.success(true))
        } onError: { error in
            print(error)
            completion(.failure(error))
        }
    }
    
}

//MARK: EXTENSIONS
extension HomeViewModel {
    func getCountryCount() -> Int {
        countriesArray.count
    }
    
    func getCountryTuple(indexpath: IndexPath) -> Country {
        guard let name = countriesArray[indexpath.row].name,
              let code = countriesArray[indexpath.row].code
        else{return ("Name Error", "Code Error")}
        return Country(name: name, code: code)
    }
}
