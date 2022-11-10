//
//  ViewController.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import UIKit
class HomeViewController: UIViewController {
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        NetworkManager.shared.fetchCountries() { response in
            guard let countries = response else {return}
            print(countries.first?.name)
            print(countries.last?.name)
        } onError: { error in
            print(error)
        }

    }
}
