//
//  UIImageViewExtensions.swift
//  Countries
//
//  Created by Kaan Turan on 12.11.2022.
//

import UIKit.UIViewController
import SVGKit

extension UIImageView {
    func downloadsvg(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let data = data, error == nil,
            let receivedicon: SVGKImage = SVGKImage(data: data),
            let image = receivedicon.uiImage
            else { return }
        DispatchQueue.main.async() {
            self.image = image
            completion()
        }
    }.resume()
}
}
