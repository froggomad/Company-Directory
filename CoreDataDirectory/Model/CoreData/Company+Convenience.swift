//
//  Company+Convenience.swift
//  CoreDataDirectory
//
//  Created by Kenny on 3/25/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation
import CoreData

extension Company {
    @discardableResult convenience init(name: String,
                                        founded: Date,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.founded = founded
    }
}


