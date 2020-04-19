//
//  AddCompanyViewController.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

@IBDesignable
class AddCompanyViewController: UIViewController {
    //=======================
    // MARK: - Properties
    private var companyNameTextField = UITextField()
    private var dateTextField = UITextField()
    private let datePicker = UIDatePicker()
    private var pickerDate: Date?
    private let datePickerView = UIView()
    private let vStack = UIStackView()

    private let cornerRadius: CGFloat = 8

    var company: Company?
    var companyController: CompanyModelController?

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
        addSaveButton()
    }

    private func setupBackButton() {
        let backItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }

    //=======================
    // MARK: - Setup ImageView
    private func createImageView() {

    }

    //=======================
    // MARK: - Setup User Inputs
    private func setupInputs() {
        //create textFields
        createRows()
        presentDatePickerView()
        setupAddEmployeesButton()
    }

    private func createRows() {
        let vStack = createVerticalParentStack()
        createRow(labelText: "Name:",
                  isInteractable: true,
                  placeholder: "Enter a Company Name",
                  addToStack: vStack,
                  textField: &companyNameTextField)
        createRow(labelText: "Date:",
                  isInteractable: false,
                  placeholder: "Select a Date Below",
                  addToStack: vStack,
                  textField: &dateTextField)
    }

    private func createVerticalParentStack() -> UIStackView {
        vStack.spacing = 12
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillProportionally
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        vStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vStack.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        return vStack
    }

    private func createRow(labelText: String,
                           isInteractable: Bool,
                           placeholder: String,
                           addToStack: UIStackView? = nil,
                           textField: inout UITextField) {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .fill
        hStack.distribution = .fillProportionally
        hStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStack)

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = labelText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        view.addSubview(label)
        hStack.addArrangedSubview(label)

        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = cornerRadius
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.delegate = self
        if !isInteractable {
            textField.backgroundColor = .systemGray2
            textField.isUserInteractionEnabled = false
        } else {
            textField.backgroundColor = .customFillColor
        }

        view.addSubview(textField)
        hStack.addArrangedSubview(textField)
        addToStack?.addArrangedSubview(hStack)
    }

    //=======================
    // MARK: - Date Picker
    private func presentDatePickerView() {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(pickerChanged), for: .valueChanged)
        setupPickerBackground()
        view.addSubview(datePicker)
        datePickerView.addSubview(datePicker)
    }

    private func setupPickerBackground() {
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: 0,
                                      height: 0
        )
        datePickerView.backgroundColor = .customFillColor
        datePickerView.layer.cornerRadius = cornerRadius
        view.addSubview(datePickerView)
        NSLayoutConstraint.activate([
            datePickerView.heightAnchor.constraint(equalToConstant: datePicker.frame.height + 40)
        ])
        vStack.addArrangedSubview(datePickerView)
    }

    private func setupAddEmployeesButton() {
        let button = UIButton()
        button.setTitle("Add Employees", for: .normal)
        button.addTarget(self,
                         action: #selector(addEmployeesSegue),
                         for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = cornerRadius
        vStack.addArrangedSubview(button)
    }

    @objc private func addEmployeesSegue() {
        guard let company = company else { return }
        let addEmployeeVC = AddEmployeeViewController()
        addEmployeeVC.company = company
        addEmployeeVC.companyController = companyController
        present(addEmployeeVC, animated: true, completion: nil)
    }

    //=======================
    // MARK: - Actions
    @objc private func pickerChanged() {
        pickerDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        guard let pickerDate = pickerDate else { return }
        dateTextField.text = dateFormatter.string(from: pickerDate)
    }

    private func addSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCompany))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc func saveCompany() {
        guard let name = companyNameTextField.text,
            !name.isEmpty,
            let founded = pickerDate
            else {
                Alert.showBasic(title: "Oops!", message: "Please enter all fields", viewController: self)
                return
        }
        let company = Company(name: name, founded: founded)
        companyController?.addCompany(company: company)
        navigationController?.popViewController(animated: true)
    }
}

extension AddCompanyViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        default:
            textField.resignFirstResponder()
        }
    }
}
