//
//  Employee+Convenience.swift
//  CoreDataDirectory
//
//  Created by Kenny on 3/27/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation
import CoreData

extension Employee {
    convenience init(name: String,
                     company: Company,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.company = company
    }
}
