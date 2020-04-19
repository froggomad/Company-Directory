//
//  CoreDataStack.swift
//  CoreDataDirectory
//
//  Created by Kenny on 3/25/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//
import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: .MODELNAME)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores \(error)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                #warning("Ask about this reset() - it's not in the solution code")
                context.reset()
                error = saveError
            }
        }
        if let error = error {throw error}
    }
}
