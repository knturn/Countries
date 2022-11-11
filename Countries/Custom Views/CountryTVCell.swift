//
//  CountryTVCell.swift
//  Countries
//
//  Created by Kaan Turan on 11.11.2022.
//

import UIKit

class CountryTVCell: UITableViewCell {
    static let identifier: String = "CountryTVCell"
    var code: String?
    // MARK: UIELEMENTS
    private lazy var cellView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var saveButton: UIButton = {
        let btn = UIButton()
        btn.isUserInteractionEnabled = true
        btn.tintColor = .black
        btn.contentMode = .scaleAspectFill
        btn.backgroundColor = .clear
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTapButton() {
        guard let code = code else{return}
        if StorageManager.shared.checkCountry(code: code) {
            self.saveButton.setImage(UIImage(systemName: "star"), for: .normal)
            StorageManager.shared.removeCountry(code: code)
        } else {
            self.saveButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            StorageManager.shared.saveCountry(code: code)
        }
    }
}
// MARK: EXTENSİON
extension CountryTVCell {
    func configure() {
        addCellViews()
        makeConstraint()
    }
    func configureCell(with tupple: Country) {
        self.cellTitle.text = tupple.name
        self.code = tupple.code
        if StorageManager.shared.checkCountry(code: tupple.code) {
            saveButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            saveButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    func addCellViews() {
        cellView.addSubview(cellTitle)
        cellView.addSubview(saveButton)
        self.contentView.addSubview(cellView)
    }
    func makeConstraint() {
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        cellTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-10)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(cellTitle.snp.right).offset(5)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        saveButton.imageView?.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(25)
            make.right.equalToSuperview().offset(-5)
        }
    }
}