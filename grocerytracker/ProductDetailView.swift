//
//  ProductDetailView.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-09-12.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    @State private var product: Product
    private var name: String

    init(name: String, product: Product) {
        self.product = product
        self.name = name
    }

    private let priceHelper = PriceHelper()

    var body: some View {
        Text(name).font(.title)
        HStack {
            Text("Price:")
            Text(priceHelper.priceFormatter.string(from: product.cost!.price as NSNumber)!)
        }

        HStack {
            Text("Amount:")
            Text(product.cost?.amountDescription ?? "Unknown Amount")
        }

        HStack {
            Text("Price Per Unit:")
            let pricePerUnitString = product.pricePerUnit != nil ? priceHelper.prettyPricePerUnit(cost: product.pricePerUnit!) : "Unknown Price Per Unit"
            Text(pricePerUnitString)
        }

        HStack {
            Text("Store:")
            Text(product.store ?? "Unknown Store")
        }

        HStack {
            Text("Brand:")
            Text(product.brand ?? "Unknown Brand")
        }

        HStack {
            Text("Last Updated:")
            Text(product.lastUpdated!, style: .date)
        }
    }
}
