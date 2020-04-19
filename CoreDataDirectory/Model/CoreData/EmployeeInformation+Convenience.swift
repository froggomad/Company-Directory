//
//  EmployeeInformation+Convenience.swift
//  CoreDataDirectory
//
//  Created by Kenny on 4/11/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation
import CoreData

extension EmployeeInformation {
    @discardableResult convenience init(employee: Employee,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.employee = employee
    }
}

extension Address {
    @discardableResult convenience init(employeeInformation: EmployeeInformation,
                                        city: String,
                                        state: String,
                                        street: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.city = city
        self.street = street
        self.employeeInformation = employeeInformation
    }
}

extension EmployeePayrollInformation {
    @discardableResult convenience init(employeeInformation: EmployeeInformation,
                                        salary: Int,
                                        taxId: Int,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.salary = Int16(salary)
        self.taxId = Int16(taxId)
        self.employeeInformation = employeeInformation
    }
}
