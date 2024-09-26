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
    @StateObject var viewModel: ViewModel
    private let priceHelper = PriceHelper()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Product Name")
                        TextField("ex: Milk", text: $viewModel.product.name)
                            .textInputAutocapitalization(.words)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Price")
                        TextField("ex: $7.99", value: $viewModel.product.price, formatter: priceHelper.priceFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Amount")
                        TextField("100", value: $viewModel.product.quantity, formatter: priceHelper.quantityFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        Picker("", selection: $viewModel.product.unit) {
                            ForEach(Cost.Unit.allCases) { option in
                                Text(option.rawValue)
                            }
                        }
                        .frame(maxWidth: 70)
                    }

                    Picker("Store", selection: $viewModel.product.store) {
                        Text("select a store").tag(Optional<String>(nil))
                        ForEach(viewModel.stores, id: \.self) {
                            Text($0)
                        }
                    }

                    HStack {
                        Text("Brand (optional)")
                        TextField("ex: Avalon", text: $viewModel.product.brand)
                            .textInputAutocapitalization(.words)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    Button("Add Product") {
                        viewModel.addProduct()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Product")
        }
    }
}
