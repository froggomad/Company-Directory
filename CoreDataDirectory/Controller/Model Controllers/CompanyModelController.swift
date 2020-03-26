//
//  CompanyModelController.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

protocol CompanyDelegate: class {
//    ///List all companies in the app
//    var companies: [Company] { get set }
//    ///Add a company to the list
//    func addCompany(_ company: Company)
//    ///Add an employee to a company
//    func addEmployee(_ company: Company, employee: Employee)
//    ///Change an employee's details
//    func updateEmployee(_ company: Company, employee: Employee)
//    ///Remove an employee from a company
//    func removeEmployee(_ company: Company, employee: Employee)
//    ///Remove a company from the list
//    func removeCompany(_ company: Company)
}

class CompanyModelController: CompanyDelegate {

//    //=======================
//    // MARK: - Properties
//    var companies: [Company] = []
//
    //=======================
    // MARK: - Create
    func addCompany(name: String, founded: Date) {
        Company(name: name, founded: founded)
    }
//
//    //=======================
//    // MARK: - Read
//
//    //=======================
//    // MARK: - Update    
//    func updateEmployee(_ company: Company, employee: Employee) {
//        guard let companyIndex = companyIndex(company),
//            let employeeIndex = companies[companyIndex]
//                .employees
//                .firstIndex(of: employee)
//        else { return }
//        companies[companyIndex].employees[employeeIndex] = employee
//    }
//
//    func addEmployee(_ company: Company, employee: Employee) {
//        guard let index = companyIndex(company) else { return }
//        companies[index].employees.append(employee)
//    }
//
//    //=======================
//    // MARK: - Delete
//    func removeCompany(_ company: Company) {
//        if let index = companyIndex(company) {
//            companies.remove(at: index)
//        }
//    }
//
//    func removeEmployee(_ company: Company, employee: Employee) {
//        if let companyIndex = companyIndex(company),
//            let employeeIndex = companies[companyIndex].employees.firstIndex(of: employee) {
//            companies[companyIndex].employees.remove(at: employeeIndex)
//        }
//    }
//
//    //=======================
//    // MARK: - Helpers
//    func companyIndex(_ company: Company) -> Int? {
//        if let index = companies.firstIndex(of: company) {
//            return index
//        }
//        return nil
//    }

}
