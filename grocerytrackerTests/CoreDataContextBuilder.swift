//
//  CoreDataContextBuilder.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-09-24.
//

import CoreData

// References:
// - https://medium.com/joshtastic-blog/coredata-testing-263d55ce6553
// - https://www.andrewcbancroft.com/2014/07/17/implement-nsmanagedobject-subclass-in-swift/ (Module must be "Current Product Module")
class CoreDataContextBuilder {

    static func buildTestContext() -> NSManagedObjectContext? {
        // Get the object model from the main bundle
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])

        // Safe unwrap it
        guard let model = managedObjectModel else {
            assertionFailure("Failed to create ManagedObjectModel")
            return nil
        }

        // Build the persistent store coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        do {
            // Create an in-memory "persistent" store
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            assertionFailure("Failed to add In Memory Persistent Store: \(error)")
            return nil
        }

        // Create a managed object context (synchronously) and assign the "temporary" persistent store coordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

        return managedObjectContext
    }
}
