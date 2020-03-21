//
//  Employee.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

struct Employee: CustomStringConvertible, Equatable {
    let identifier: UUID
    var name: String
    var address: String

    var description: String {
        "Employee \(name), Id: \(identifier)"
    }

    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
