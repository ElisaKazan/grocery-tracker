//
//  grocerytrackerApp.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-14.
//

import SwiftUI

@main
struct grocerytrackerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            GroceryView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
