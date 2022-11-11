//
//  DetailViewController.swift
//  Countries
//
//  Created by Kaan Turan on 11.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    // MARK: UI ELEMENTS
    private lazy var flagImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(systemName: "person.fill")
        return img
    }()
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    // MARK: FUNCS
    private func addSubviews() {
        view.addSubview(flagImage)
        makeConstraints()
    }
    private func makeConstraints() {
        flagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-100)
        }
    }

}
