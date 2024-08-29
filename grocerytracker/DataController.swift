//
//  DataController.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-14.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "GroceryTracker")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
}
