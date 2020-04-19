//
//  CompanyModelController.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

class CompanyModelController {

    //=======================
    // MARK: - Create
    func addCompany(company: Company) {
        #warning("Test thoroughly")
        save()
    }

    //=======================
    // MARK: - Update
    func updateEmployee(_ company: Company, employee: Employee, name: String) {
        employee.name = name
        employee.company = company
        save()
    }

    func addEmployee(_ company: Company, employee: Employee) {
        company.addToEmployees(employee)
        save()
    }

    func save() {
        do {
            try CoreDataStack.shared.save()
        } catch let saveError {
            NSLog(
                """
                Error Saving To CoreData: \(#file), \(#function), \(#line) -
                \(saveError)
                """
            )
        }
    }

    //=======================
    // MARK: - Delete
    func removeCompany(_ company: Company) {
        CoreDataStack.shared.mainContext.delete(company)
        save()
    }

    func removeEmployee(_ company: Company, employee: Employee) {
        company.removeFromEmployees(employee)
        save()
    }

}
