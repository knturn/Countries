//
//  UIViewControllerExtensions.swift
//  Countries
//
//  Created by Kaan Turan on 12.11.2022.
//

import UIKit.UIViewController
extension UIViewController {
    func displayAlert(title: String? = nil, message: String, buttonTitle: String = "OK", handler: @escaping (UIAlertAction) -> Void = {_ in } ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
    func setNavigationTitle(title: String) {
        let font = UIFont.systemFont(ofSize: 25, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = title
    }
    
}
