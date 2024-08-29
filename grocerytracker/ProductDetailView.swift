//
//  ProductDetailView.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-08-26.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    @State private var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    private let priceFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    var body: some View {
        let productName = product.name ?? "Unknown"
        
        Text(productName).font(.title)
        HStack {
            Text("Price:")
            Text(priceFormatter.string(from: product.price as NSNumber)!)
        }
        
        HStack {
            Text("Amount:")
            Text(product.amount.description)
        }
        
        HStack {
            Text("Store:")
            Text(product.store ?? "Unknown")
        }
        
        HStack {
            Text("Last Updated:")
            Text(product.lastUpdated!, style: .date)
        }
        
        
    }
}
