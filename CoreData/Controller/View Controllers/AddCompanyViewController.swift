//
//  AddCompanyViewController.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

protocol AddCompanyDelegate: class {
    func addCompany(_ company: Company)
}

class AddCompanyViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        self.title = "Add Company"
        view.backgroundColor = .tableViewBackgroundColor
        setupBackButton()
        setupTextFields()
    }

    func setupBackButton() {
        let backItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }

    func setupTextFields() {
        let hStackFrame = CGRect(x: 20, y: 40, width: view.frame.size.width - 40, height: view.frame.size.height / 3)
        //Horizontal Stack
        let hStack = UIStackView(frame: hStackFrame)
        hStack.axis = .horizontal
        hStack.alignment = .fill
        hStack.distribution = .fill
        hStack.translatesAutoresizingMaskIntoConstraints = false
        var frame = CGRect(x: hStack.frame.minX + 20,
                           y: 20,
                           width: hStack.frame.width - 40,
                           height: 40
        )
        //add textFields
        let companyNameField = UITextField(frame: frame)
        companyNameField.placeholder = "Enter a Company Name"
        hStack.addArrangedSubview(companyNameField)
        
        view.addSubview(hStack)
    }
}
