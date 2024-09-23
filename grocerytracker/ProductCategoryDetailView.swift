//
//  ProductDetailView.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-26.
//

import Foundation
import SwiftUI

struct ProductCategoryDetailView: View {
    @State private var categories: FetchedResults<ProductCategory>
    @State private var category: ProductCategory

    init(categories: FetchedResults<ProductCategory>, category: ProductCategory) {
        self.categories = categories
        self.category = category
    }
    
    private let priceHelper = PriceHelper()

    var body: some View {
        let categoryName = category.name ?? "Unknown Category"
        let products = category.products?.allObjects as? [Product] ?? []

        Text(categoryName).font(.title)

        NavigationStack {
            List {
                ForEach(products, id: \.id) { product in
                    NavigationLink {
                        ProductDetailView(name: categoryName, product: product)
                    } label: {
                        HStack {
                            Text(product.store ?? "Unknown Store")
                            VStack {
                                Text(priceHelper.prettyPricePerUnit(cost: product.cost!))
                                    .font(.headline)
                                let pricePerUnit = priceHelper.pricePerUnit(cost: product.cost!)
                                Text("(\(priceHelper.prettyPricePerUnit(cost: pricePerUnit))")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
        }
    }
}
