//
//  TabbarViewController.swift
//  Countries
//
//  Created by Kaan Turan on 13.11.2022.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVCs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = ""
    }
    
    func createNavController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationController?.navigationBar.prefersLargeTitles = true
        navController.navigationItem.title = title
        navController.navigationItem.backButtonTitle = nil
        return navController
    }
    func setupVCs() {
        viewControllers = [
            createNavController(for: HomeViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: SavedCountriesViewController(), title: NSLocalizedString("Saved", comment: ""), image: UIImage(systemName: "heart.square.fill")!)
        ]
    }
    
}
