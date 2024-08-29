//
//  AddProductView.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-26.
//

import Foundation
import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var productName = ""
    @State private var price: Double = 0.0
    @State private var store: String = "Fresh St. Market"
    
    private var stores = ["Fresh St. Market", "Costco", "No Frills", "London Drugs", "Shoppers Drugmart", "Independent", "Choices", "T&T"]
    
    private let priceFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Product Name")
                        TextField("ex: butter", text: $productName)
                    }
                    HStack {
                        Text("Price")
                        TextField("ex: $7.99", value: $price, formatter: priceFormatter)
                            .keyboardType(.decimalPad)
                    }
                    Picker("Store", selection: $store) {
                        Text("select a store").tag(Optional<String>(nil))
                        ForEach(stores, id: \.self) {
                            Text($0)
                        }
                    }
                    Text("You selected: \(store)")
                }
                
                Section {
                    Button("Add Product") {
                        let product = Product(context: moc)
                        product.id = UUID()
                        product.name = productName
                        product.price = price
                        product.store = $store.wrappedValue
                        product.lastUpdated = Date()
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

#Preview {
    AddProductView()
}
