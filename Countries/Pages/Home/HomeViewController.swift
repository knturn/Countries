//
//  ViewController.swift
//  Countries
//
//  Created by Kaan Turan on 10.11.2022.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
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
        setNavigationTitle()
        view.backgroundColor = .white
        fetchCountries()
        configureSubViews()
    }
    
    // MARK: FUNCS
    private func setNavigationTitle() {
        let font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        let attributes = [NSAttributedString.Key.font: font]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = "Countries"
    }
    
    private func fetchCountries() {
        viewModel.fetchCountries() { [weak self] result in
            guard let self = self else{return}
            if result {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else{return}
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Alert", message: "Error happend while fetching countries. Try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func configureSubViews() {
        view.addSubview(tableView)
        makeConstraint()
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
        navigationController?.pushViewController(DetailViewController(), animated: true)
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


