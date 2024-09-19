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
            Text(priceHelper.priceFormatter.string(from: product.price as NSNumber)!)
        }

        HStack {
            Text("Amount:")
            Text(product.amount?.description ?? "Unknown Amount")
        }

        HStack {
            Text("Price Per Unit:")
            let pricePerUnit: (Double, Amount) = priceHelper.pricePerUnit(price: product.price, amount: product.amount!)
            let prettyPPU = priceHelper.prettyPricePerUnit(price: pricePerUnit.0, amount: pricePerUnit.1)
            Text(prettyPPU)
        }

        HStack {
            Text("Store:")
            Text(product.store ?? "Unknown")
        }

        HStack {
            Text("Sale Price:")
            let priceToDisplay = product.salePrice > 0 ? priceHelper.priceFormatter.string(from: product.salePrice as NSNumber)! : "Unknown"
            Text(priceToDisplay)
        }

        HStack {
            Text("Brand:")
            Text(product.brand ?? "Unknown")
        }

        HStack {
            Text("Last Updated:")
            Text(product.lastUpdated!, style: .date)
        }
    }
}
