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
    //=======================
    // MARK: - Properties
    private weak var companyNameTextField: UITextField!
    private weak var dateTextField: UITextField!
    private let datePicker = UIDatePicker()
    private var pickerDate: Date?
    private let bgView = UIView()

    var company: Company?
    weak var delegate: AddCompanyDelegate?

    //=======================
    // MARK: - View Lifecycle
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
        setupInput()
    }

    func setupBackButton() {
        let backItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }

    func setupInput() {
        companyNameTextField = createTextField(placeholder: "Enter a Company Name")
        dateTextField = createTextField(placeholder: "Enter Date Founded")
        dateTextField.delegate = self
        //Horizontal Stack
        let vStack = createTextFieldStack()
        //add arrangedSubviews
        vStack.addArrangedSubview(companyNameTextField)
        vStack.addArrangedSubview(dateTextField)
    }

    func presentDatePickerView() {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(pickerChanged), for: .valueChanged)

        bgView.frame = CGRect(x: dateTextField.frame.minX,
                              y: dateTextField.center.y,
                              width: view.frame.width - 40,
                              height: datePicker.frame.height + 40
        )
        bgView.center.x = view.center.x
        bgView.backgroundColor = .customFillColor
        view.addSubview(bgView)
        view.addSubview(datePicker)
        bgView.addSubview(datePicker)
    }

    @objc func pickerChanged() {
        pickerDate = datePicker.date
        bgView.removeFromSuperview()
    }

    func addCompany() {
        guard let company = company else { return }
        delegate?.addCompany(company)
    }

    func createTextFieldStack() -> UIStackView {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillProportionally
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        vStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vStack.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        vStack.spacing = 8
        return vStack
    }

    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .systemGray2
        view.addSubview(textField)
        return textField
    }
}

extension AddCompanyViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case dateTextField:
            presentDatePickerView()
        default:
            break
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case dateTextField:
            print()
        default:
            break
        }

    }
}
