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

    private var company: Company?
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

    private func setupViews() {
        self.title = "Add Company"
        view.backgroundColor = .tableViewBackgroundColor
        setupBackButton()
        setupInputs()
    }

    private func setupBackButton() {
        let backItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }

    //=======================
    // MARK: - Setup User Inputs
    private func setupInputs() {
        //create textFields
        setupTextFields()
        //Vertical Stack
        let vStack = createTextFieldStack()
        vStack.addArrangedSubview(companyNameTextField)
        vStack.addArrangedSubview(dateTextField)
    }

    private func createTextFieldStack() -> UIStackView {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillProportionally
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        vStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vStack.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        vStack.spacing = 12
        return vStack
    }

    private func setupTextFields() {
        companyNameTextField = createTextField(placeholder: "Enter a Company Name")
        dateTextField = createTextField(placeholder: "Enter Date Founded")
        companyNameTextField.delegate = self
        dateTextField.delegate = self
    }

    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .systemGray2
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.addSubview(textField)
        return textField
    }

    //=======================
    // MARK: - Date Picker
    private func presentDatePickerView() {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(pickerChanged), for: .valueChanged)
        setupPickerBackground()
        view.addSubview(datePicker)
        bgView.addSubview(datePicker)
    }

    private func setupPickerBackground() {
        bgView.frame = CGRect(x: dateTextField.frame.minX,
                              y: dateTextField.center.y,
                              width: view.frame.width - 40,
                              height: datePicker.frame.height + 40
        )
        bgView.center.x = view.center.x
        bgView.backgroundColor = .customFillColor
        bgView.layer.cornerRadius = 20
        view.addSubview(bgView)
    }

    @objc private func pickerChanged() {
        pickerDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        guard let pickerDate = pickerDate else { return }
        dateTextField.text = dateFormatter.string(from: pickerDate)
        bgView.removeFromSuperview()
    }

    //=======================
    // MARK: - Delegate Method
    private func addCompany() {
        guard let company = company else { return }
        delegate?.addCompany(company)
    }
}

extension AddCompanyViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case dateTextField:
            dateTextField.becomeFirstResponder()
            guard let text = dateTextField.text else { return }
            presentDatePickerView()
        default:
            textField.becomeFirstResponder()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        default:
            textField.resignFirstResponder()
        }
    }
}
