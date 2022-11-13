//
//  SavedCountriesViewController.swift
//  Countries
//
//  Created by Kaan Turan on 13.11.2022.
//

import UIKit
import SnapKit
class SavedCountriesViewController: UIViewController {
    let viewModel = SavedCountriesViewModel()
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
        configureSubViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationTitle(title: "Countries")
        viewModel.updateSavedCountries()
        tableView.reloadData()
    }
    
    // MARK: FUNCS
    private func configureSubViews() {
        view.addSubview(tableView)
        makeConstraint()
    }
    
    private func pushToDetailPage(indexPath: IndexPath) {
        let countryCode = viewModel.getCountryTuple(indexpath: indexPath).code
        let detailViewModel = DetailViewModel(countryCode: countryCode)
        let vc = DetailViewController(viewModel: detailViewModel)
        navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: TableView Delegate & DataSource
extension SavedCountriesViewController: ConfigureToTableView {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTVCell.identifier, for: indexPath) as? CountryTVCell else{return UITableViewCell()}
        cell.delegate = self
        cell.configureCell(with: viewModel.getCountryTuple(indexpath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountriesCount()
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
extension SavedCountriesViewController {
    private func makeConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SavedCountriesViewController: CountryTVCellDelegate {
    func starTapped() {
        self.viewModel.updateSavedCountries()
        tableView.reloadData()
    }
}
