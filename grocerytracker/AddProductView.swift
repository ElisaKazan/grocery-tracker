//
//  AddProductView.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-26.
//

import Foundation
import SwiftUI

struct AddProductView: View {
    @State private var categories: FetchedResults<ProductCategory>

    init(categories: FetchedResults<ProductCategory>) {
        self.categories = categories
    }

    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    // Required Properties
    @State private var productName = ""
    @State private var price: Double = 0.0
    @State private var quantity: Double = 0.0
    @State private var unit: Cost.Unit = .unit
    @State private var store: String = "Fresh St. Market"
    
    // Optional Properties
    @State private var salePrice: Double = 0.0
    @State private var brand: String = ""

    private var stores = ["Fresh St. Market", "Costco", "No Frills", "London Drugs", "Shoppers Drugmart", "Independent", "Choices", "T&T"]
    
    private let priceHelper = PriceHelper()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Product Name")
                        TextField("ex: Milk", text: $productName)
                            .textInputAutocapitalization(.words)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Price")
                        TextField("ex: $7.99", value: $price, formatter: priceHelper.priceFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Amount")
                        TextField("100", value: $quantity, formatter: priceHelper.quantityFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        Picker("", selection: $unit) {
                            ForEach(Cost.Unit.allCases) { option in
                                Text(option.rawValue)
                            }
                        }
                        .frame(maxWidth: 70)
                    }

                    Picker("Store", selection: $store) {
                        Text("select a store").tag(Optional<String>(nil))
                        ForEach(stores, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    HStack {
                        Text("Sale Price (optional)")
                        Spacer()
                        TextField("ex: $3.50", value: $salePrice, formatter: priceHelper.priceFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Brand (optional)")
                        TextField("ex: Avalon", text: $brand)
                            .textInputAutocapitalization(.words)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    Button("Add Product") {
                        // Check if category already exists
                        if let existingCategory = categories.first(where: { category in
                            category.name == productName
                        }) {
                            // Create new product within existing category
                            let newProduct = Product(context: moc)
                            newProduct.id = UUID()
                            newProduct.price = price
                            newProduct.cost = Cost(price: price, quantity: quantity, unit: unit)
                            newProduct.store = $store.wrappedValue
                            newProduct.salePrice = salePrice
                            newProduct.brand = brand.isEmpty ? nil : brand
                            newProduct.lastUpdated = Date()

                            var products = existingCategory.products?.allObjects ?? []
                            products.append(newProduct)

                            existingCategory.products = NSSet(array: products)
                        } else {
                            // Create new product within a new category
                            let newCategory = ProductCategory(context: moc)
                            newCategory.id = UUID()
                            newCategory.name = productName

                            let newProduct = Product(context: moc)

                            newProduct.id = UUID()
                            newProduct.price = price
                            newProduct.cost = Cost(price: price, quantity: quantity, unit: unit)
                            newProduct.store = $store.wrappedValue
                            newProduct.salePrice = salePrice
                            newProduct.brand = brand.isEmpty ? nil : brand
                            newProduct.lastUpdated = Date()

                            newCategory.products = NSSet(array: [newProduct])
                        }

                        if moc.hasChanges {
                            try? moc.save()
                        }
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Product")
        }
    }
}

//#Preview {
//    AddProductView()
//}
