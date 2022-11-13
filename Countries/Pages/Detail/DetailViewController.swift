//
//  DetailViewController.swift
//  Countries
//
//  Created by Kaan Turan on 11.11.2022.
//

import UIKit
class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel!
    let spinner = UIActivityIndicatorView()
    
    // MARK: UI ELEMENTS
    private lazy var flagImage: UIImageView = {
        var img = UIImageView()
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFit
        if let url = viewModel.getFlagURL() {
            img.showSpinner(this: spinner)
            img.downloadsvg(from: url) { [weak self] in
                guard let self = self else {return}
                self.spinner.stopAnimating()
            }
        }
        return img
    }()
    private lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = getCountryCodeText(countryCode: viewModel.getCountryCode())
        label.backgroundColor = .lightText
        return label
    }()
    private lazy var moreInfoButton: UIButton = {
        let bttn = UIButton()
        bttn.isUserInteractionEnabled = true
        bttn.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
        bttn.backgroundColor = .blue
        return bttn
    }()
    
    private lazy var buttonLabel: UILabel = {
        let label = UILabel()
        let infoTextStyle = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.white]
        let infoText = NSMutableAttributedString(string: "For More Information", attributes: infoTextStyle)
        label.attributedText = infoText
        label.layer.backgroundColor = UIColor.clear.cgColor
        return label
    }()
    
    private lazy var buttonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        image.tintColor = .white
        image.image = UIImage(systemName: "arrow.up.forward.app.fill")
        return image
    }()
    
    //MARK: LIFE CYCLE
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = rightBarButton()
        fetchCountryDetails()
    }
    
    // MARK: FUNCS
    @objc private func didTapInfoButton() {
        guard let url = viewModel.pushToWikidata() else {return}
        UIApplication.shared.open(url)
    }
    
    private func rightBarButton() -> UIBarButtonItem {
        let image = viewModel.getImageState()?.image
        let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(didTapRightBarButton))
        return button
    }
    
    @objc private func didTapRightBarButton() {
        viewModel.didTapRightButton() { state in
            let image = state.image
            navigationItem.rightBarButtonItem?.image = image
        }
    }
    private func fetchCountryDetails() {
        viewModel.fetchCountryDetails() { [weak self] result in
            guard let self = self else{return}
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.addSubviews()
                    self.setNavigationTitle(title: self.viewModel.getCountryName())
                case .failure(let error):
                    self.displayAlert(message: error.localizedDescription)
                }
            }
        }
    }
    private func addSubviews() {
        view.addSubview(flagImage)
        view.addSubview(countryNameLabel)
        moreInfoButton.addSubview(buttonLabel)
        moreInfoButton.addSubview(buttonImage)
        view.addSubview(moreInfoButton)
        makeConstraints()
    }
    private func makeConstraints() {
        flagImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.left.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        countryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(flagImage.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        moreInfoButton.snp.makeConstraints { make in
            make.top.equalTo(countryNameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        buttonImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.right.equalToSuperview().offset(-5)
            make.left.equalTo(buttonLabel.snp.right).offset(5)
        }
        buttonLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(2)
        }
        
    }
}
extension DetailViewController {
    private func getCountryCodeText(countryCode: String) -> NSAttributedString {
        let describerStyle = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
        let describStyle = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
        let describer = NSMutableAttributedString(string:"Country Code: ", attributes: describerStyle)
        let describ = NSMutableAttributedString(string: countryCode, attributes: describStyle)
        describer.append(describ)
        return describer
    }
}
