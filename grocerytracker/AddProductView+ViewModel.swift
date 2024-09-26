//
//  AddProductView+ViewModel.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-09-26.
//

import Foundation
import CoreData
import SwiftUI

extension AddProductView {
    public class ViewModel: ObservableObject {
        private var moc: NSManagedObjectContext

        let stores = ["Fresh St. Market",
                      "Costco",
                      "No Frills",
                      "London Drugs",
                      "Shoppers Drugmart",
                      "Independent",
                      "Choices",
                      "T&T"]

        var categories: FetchedResults<ProductCategory>

        @Published var product = ProductModel(name: "", price: 0.0, quantity: 0, unit: .unit, store: "Fresh St. Market", brand: "")

        init(moc: NSManagedObjectContext, categories: FetchedResults<ProductCategory>) {
            self.moc = moc
            self.categories = categories
        }

        func addProduct() {
            // Create new Product
            let newProduct = Product(context: moc)
            newProduct.id = UUID()
            newProduct.cost = Cost(price: product.price, quantity: product.quantity, unit: product.unit)
            newProduct.store = product.store
            newProduct.brand = product.brand.isEmpty ? nil : product.brand
            newProduct.lastUpdated = Date()

            // Check if category already exists
            if let existingCategory = categories.first(where: { category in
                category.name == product.name
            }) {
                // Create new product within existing category
                var products = existingCategory.products?.allObjects ?? []
                products.append(newProduct)
                existingCategory.products = NSSet(array: products)
            } else {
                // Create new product within a new category
                let newCategory = ProductCategory(context: moc)
                newCategory.id = UUID()
                newCategory.name = product.name
                newCategory.products = NSSet(array: [newProduct])
            }

            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

struct ProductModel {
    // Required Properties
    var name: String
    var price: Double
    var quantity: Double
    var unit: Cost.Unit
    var store: String

    // Optional Properties
    var brand: String
}

