//
//  CompanyModelController.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

protocol CompanyDelegate: class {
    var companies: [Company] { get set }
    func addCompany(_ company: Company)
    func addEmployee(_ company: Company, employee: Employee)
    func updateEmployee(_ company: Company, employee: Employee)
    func removeEmployee(_ company: Company, employee: Employee)
    func removeCompany(_ company: Company)
}

class CompanyModelController: CompanyDelegate {

    //=======================
    // MARK: - Properties
    var companies: [Company] = []

    //=======================
    // MARK: - Create
    func addCompany(_ company: Company) {
        if companyIndex(company) == nil {
            companies.append(company)
        }
    }

    //=======================
    // MARK: - Read

    //=======================
    // MARK: - Update    
    func updateEmployee(_ company: Company, employee: Employee) {
        guard let companyIndex = companyIndex(company),
            let employeeIndex = companies[companyIndex]
                .employees
                .firstIndex(of: employee)
        else { return }
        companies[companyIndex].employees[employeeIndex] = employee
    }

    func addEmployee(_ company: Company, employee: Employee) {
        guard let index = companyIndex(company) else { return }
        companies[index].employees.append(employee)
    }

    //=======================
    // MARK: - Delete
    func removeCompany(_ company: Company) {
        if let index = companyIndex(company) {
            companies.remove(at: index)
        }
    }

    func removeEmployee(_ company: Company, employee: Employee) {
        if let companyIndex = companyIndex(company),
            let employeeIndex = companies[companyIndex].employees.firstIndex(of: employee) {
            companies[companyIndex].employees.remove(at: employeeIndex)
        }
    }

    //=======================
    // MARK: - Helpers
    func companyIndex(_ company: Company) -> Int? {
        if let index = companies.firstIndex(of: company) {
            return index
        }
        return nil
    }

}
