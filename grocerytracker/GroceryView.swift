//
//  ContentView.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-14.
//

import SwiftUI

struct GroceryView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var products: FetchedResults<Product>
    
    @State private var showingAddNewProduct = false
    
    // TODO: Move this to a shared location
    private let priceFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(products, id: \.id) { product in
                    let name = product.name ?? "Unknown"
                    let price = priceFormatter.string(from: product.price as NSNumber)
                    NavigationLink {
                        ProductDetailView(product: product)
                    } label: {
                        HStack{
                            Text(name)
                                .font(.headline)
                            Text(price!)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: removeProduct)
            }
            .navigationTitle("Grocery Tracker")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    
                    Button("Add Product", systemImage: "plus") {
                        showingAddNewProduct.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddNewProduct) {
                AddProductView()
            }
        }
    }
    
    func removeProduct(at offsets: IndexSet) {
        for index in offsets {
            let productToRemove = products[index]
            moc.delete(productToRemove)
            try? moc.save()
        }
    }
}

#Preview {
    GroceryView()
}
