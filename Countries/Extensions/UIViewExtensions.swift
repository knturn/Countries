//
//  UIViewExtensions.swift
//  Countries
//
//  Created by Kaan Turan on 12.11.2022.
//

import UIKit.UIView
extension UIView {
    func showSpinner(this spinner: UIActivityIndicatorView) {
        spinner.startAnimating()
        spinner.style = .large
        spinner.sizeToFit()
        spinner.color = .black
        spinner.hidesWhenStopped = true
        spinner.backgroundColor = .lightGray
        self.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
