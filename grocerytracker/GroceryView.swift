//
//  ContentView.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-14.
//

import SwiftUI

struct GroceryView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<ProductCategory>

    @State private var showingAddNewProduct = false

    // Delete a category with alert
    @State private var showingDeleteAlert = false
    @State private var deletedIndexSet: IndexSet = IndexSet()

    @State private var searchText = ""

    private let priceHelper = PriceHelper()

    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.id) { category in
                    let name = category.name ?? "Unknown Category"
                    let productCount = category.products?.count ?? 0
                    NavigationLink {
                        ProductCategoryDetailView(categories: categories, category: category)
                    } label: {
                        HStack {
                            Text(name)
                                .font(.headline)
                            Spacer()
                            Text(productCount.description)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete { indexSet in
                    deletedIndexSet = indexSet
                    showingDeleteAlert = true
                }
            }
            .alert("Are you sure you want to delete this product?", isPresented: $showingDeleteAlert, actions: {
                Button("Yes", role: .destructive) {
                    removeCategory(at: deletedIndexSet)
                    deletedIndexSet = IndexSet()
                }
                Button("Cancel", role: .cancel) {
                    deletedIndexSet = IndexSet()
                }
            })
            .navigationTitle("Grocery Tracker")
            .searchable(text: $searchText, prompt: "Search for a product")
            .onChange(of: searchText) { _, newSearch in
                if newSearch.isEmpty {
                    categories.nsPredicate = NSPredicate(value: true)
                } else {
                    categories.nsPredicate = NSPredicate(format: "name CONTAINS [cd] %@", newSearch)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    
                    Button("Add Product", systemImage: "plus") {
                        showingAddNewProduct.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddNewProduct) {
                AddProductView(viewModel: .init(moc: moc, categories: categories))
            }
        }
    }

    func removeCategory(at offsets: IndexSet) {
        for index in offsets {
            let categoryToRemove = categories[index]
            moc.delete(categoryToRemove)
            try? moc.save()
        }
    }
}

#Preview {
    GroceryView()
}
