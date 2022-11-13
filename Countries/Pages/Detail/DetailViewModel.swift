//
//  DetailViewModel.swift
//  Countries
//
//  Created by Kaan Turan on 11.11.2022.
//

import Foundation

class DetailViewModel {
    private let countryCode: String!
    private var countryDetailModel: CountryDetailModel?
    
    init(countryCode: String) {
        self.countryCode = countryCode
    }
    
    func fetchCountryDetails(completion: @escaping (Result<Bool,Error>) -> Void) {
        NetworkManager.shared.fetchCountryDetail(code: countryCode) { model in
            self.countryDetailModel = model
            completion(.success(true))
        } onError: { error in
            completion(.failure(error))
            print(error)
        }
    }
    
    func getFlagURL() -> URL? {
        guard let model = countryDetailModel else {return nil}
        return URL(string: model.flagUrl)
    }
    func getCountryCode() -> String {
        countryCode
    }
    func getCountryName() -> String {
        guard let model = countryDetailModel else {return ""}
        return model.name
    }
    
    func pushToWikidata() -> URL? {
        countryDetailModel?.getWikiUrl()
    }
    
    func getImageState() -> CurrentFavState? {
        StorageManager.shared.checkCountry(code: countryCode) ? CurrentFavState.saved : CurrentFavState.notSaved
    }
    
    func didTapRightButton(completion: (CurrentFavState) -> Void) {
        guard let name = countryDetailModel?.name,
              let code =  countryDetailModel?.code else{return}
        let country: Country = (name: name, code: code)
        if StorageManager.shared.checkCountry(code: country.code) {
            completion(.notSaved)
            StorageManager.shared.removeCountry(country: country)
        } else {
            completion(.saved)
            StorageManager.shared.saveCountry(country: country)
        }
    }
}
