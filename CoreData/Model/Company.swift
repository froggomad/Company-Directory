//
//  Company.swift
//  CoreData
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

struct Company: CustomStringConvertible, Equatable {
    static func == (lhs: Company, rhs: Company) -> Bool {
        lhs.name == rhs.name && lhs.founded == rhs.founded
    }

    let name: String
    let founded: Date
    var employees: [Employee]

    var description: String {
        "\(name) was founded on \(date), and currently has \(employees.count) employees"
    }

    private var date: String {
        return dateFormatter.string(from: founded)
    }

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        return dateFormatter
    }

}
