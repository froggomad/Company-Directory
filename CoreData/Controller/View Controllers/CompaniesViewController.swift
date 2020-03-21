//
//  ViewController.swift
//  CoreData
//
//  Created by Kenny on 3/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class CompaniesViewController: UITableViewController {

    //=======================
    // MARK: - Properties
    var companyController = CompanyModelController()

    //=======================
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        companies = [
//            Company(name: "Apple", founded: Date(), employees: []),
//            Company(name: "Facebook", founded: Date(), employees: []),
//            Company(name: "Google", founded: Date(), employees: [])
//        ]
        for company in companyController.companies {
            print(company)
        }
    }

    private func setupViews() {
        setupBackgroundView()
        setupNavigationBar()
        setupTableView()
    }

    private func setupBackgroundView() {
        view.backgroundColor = .systemBackground
    }

    //=======================
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        setupNavBarTitle()
        setupBarButtonItems()
    }

    private func setupNavBarTitle() {
        navigationItem.title = "Companies"
    }

    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .plusSign,
            style: .plain,
            target: self,
            action: #selector(handleAddCompany))
    }

    @objc private func handleAddCompany() {
        print("Adding Company")
        let addCompanyVC = AddCompanyViewController()
        navigationController?.pushViewController(addCompanyVC, animated: true)
    }

    //=======================
    // MARK: - TableView Views

    private func setupTableView() {
        tableView.backgroundColor = .tableViewBackgroundColor
        tableView.tableFooterView = UIView()
        registerCell()
    }

    private func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .companyCellId)
    }

    //=======================
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companyController.companies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .companyCellId, for: indexPath)
        cell.backgroundColor = UIColor.companyCellColor
        cell.textLabel?.text = companyController.companies[indexPath.row].name.uppercased()
        cell.textLabel?.textColor = .systemBackground
        let font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.font = font
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .tableViewHeaderColor
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
