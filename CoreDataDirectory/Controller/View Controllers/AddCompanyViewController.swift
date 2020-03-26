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
    private var companyNameTextField = UITextField()
    private var dateTextField = UITextField()
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
    }

    private func createRows() {
        let vStack = createVerticalParentStack()
        createRow(labelText: "Name:",
                  placeholder: "Enter a Company Name",
                  addToStack: vStack,
                  textField: &companyNameTextField)
        createRow(labelText: "Date:",
                  placeholder: "Enter Date Founded",
                  addToStack: vStack,
                  textField: &dateTextField)
    }

    private func createVerticalParentStack() -> UIStackView {
        let vStack = UIStackView()
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
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .systemGray2
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.delegate = self
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
        //company = Company(name: name, founded: founded, employees: [])
        navigationController?.popViewController(animated: true)
        addCompany()
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
