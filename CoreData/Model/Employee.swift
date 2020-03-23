//
//  Employee.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

extension Employee: CustomStringConvertible, Equatable {

    public var description: String {
        "\(String(describing: name))"
    }

    public static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name == rhs.name
    }
}
