//
//  ViewController.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()
    // MARK: UI ELEMENT
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTVCell.self, forCellReuseIdentifier: CountryTVCell.identifier)
        return tableView
    }()
    
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchCountries()
        configureSubViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationTitle(title: "Countries")
        tableView.reloadData()
    }
    
    // MARK: FUNCS
    private func fetchCountries() {
        viewModel.fetchCountries() { [weak self] result in
            guard let self = self else{return}
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.tableView.reloadData()
                case .failure(let error):
                    self.displayAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func configureSubViews() {
        view.addSubview(tableView)
        makeConstraint()
    }
    
    private func pushToDetailPage(indexPath: IndexPath) {
        let countryCode = self.viewModel.getCountryTuple(indexpath: indexPath).code
        let detailViewModel = DetailViewModel(countryCode: countryCode)
        let vc = DetailViewController(viewModel: detailViewModel)
        navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: TableView Delegate & DataSource
extension HomeViewController: ConfigureToTableView {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTVCell.identifier, for: indexPath) as? CountryTVCell else{return UITableViewCell()}
        let countryTupple: Country = viewModel.getCountryTuple(indexpath: indexPath)
        cell.configureCell(with: countryTupple)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countriesArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToDetailPage(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}
// MARK: Constraints
extension HomeViewController {
    private func makeConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


