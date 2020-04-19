//
//  ViewController.swift
//  CoreData
//
//  Created by Kenny on 3/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: UITableViewController {

    //=======================
    // MARK: - Properties
    private let customCell = CompanyTableViewCell(style: .default,
                                          reuseIdentifier: .companyCellId)
    private var companyController = CompanyModelController()
    //=======================
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
    // MARK: - CoreData
    lazy var fetchedResultsController: NSFetchedResultsController<Company> = {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.sortDescriptors = [

        ]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: "name",
                                             cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch let frcError {
            NSLog(
                """
                Error fetching data from frc: \(#file), \(#function), \(#line) -
                \(frcError)
                """)
        }
        return frc
    }()

    // MARK: Navigation Bar
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
        let addCompanyVC = AddCompanyViewController()
        addCompanyVC.companyController = companyController
        navigationController?.pushViewController(addCompanyVC, animated: true)
    }

    // MARK: TableView
    private func setupTableView() {
        tableView.backgroundColor = .tableViewBackgroundColor
        tableView.tableFooterView = UIView()
        registerCell()
    }

    private func registerCell() {
        tableView.register(CompanyTableViewCell.self,
                           forCellReuseIdentifier: .companyCellId)
    }

    //=======================
    // MARK: - TableView DataSource
   override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .companyCellId,
                                                       for: indexPath) as? CompanyTableViewCell,
            let company = fetchedResultsController.fetchedObjects?[indexPath.row]
        else { return CompanyTableViewCell() }

        cell.company = company
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionName = fetchedResultsController.sections?[section].name else { return nil }
        let view = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .black)

        label.text = sectionName
        label.numberOfLines = 0
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)

        ])
        view.backgroundColor = .tableViewHeaderColor
        return view
    }
}

extension CompaniesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }

        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                        didChange anObject: Any,
                        at indexPath: IndexPath?,
                        for type: NSFetchedResultsChangeType,
                        newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}
