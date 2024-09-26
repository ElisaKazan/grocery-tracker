//
//  PriceHelper.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-09-07.
//

import Foundation

public class PriceHelper {
    public let priceFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()

    // Use for user input of quantity (i.e. preserve 1.9 kg)
    public let quantityFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesSignificantDigits = true
        return numberFormatter
    }()

    // Calculates the price per unit given price and amount
    // If g or ml, price will be per 100 units (i.e. 100 ml)
    // If kg, l or unit, price will be per single unit (i.e. 1 kg)
    public func pricePerUnit(cost: Cost) -> Cost {
        let pricePerUnit: Double
        let quantity: Double

        switch cost.unit {
        case .milliliter, .gram:
            pricePerUnit = (cost.price / cost.quantity) * 100
            quantity = 100
        case .litre, .kilogram, .unit:
            pricePerUnit = cost.price / cost.quantity
            quantity = 1
        }

        return Cost(price: pricePerUnit, quantity: quantity, unit: cost.unit)
    }

    // String representation of price per unit
    public func prettyPricePerUnit(cost: Cost) -> String {
        let prettyPrice = priceFormatter.string(for: cost.price)!
        let prettyQuantity = NumberFormatter().string(for: cost.quantity)!

        if cost.quantity == 1 {
            // No need to show quantity (ex: "$10 / kg")
            return "\(prettyPrice) / \(cost.unit.rawValue)"
        } else {
            return "\(prettyPrice) / \(prettyQuantity) \(cost.unit.rawValue)"
        }
    }

    // Determines the cheapest product out of an array of products based on price per unit.
    // This basic function assumes all units are the same and will include unit conversion later.
    public func cheapestProduct(products: [Product]) -> Product {
        var cheapestProduct: Product = products[0]

        for product in products {
            if product.pricePerUnit!.price < cheapestProduct.pricePerUnit!.price {
                cheapestProduct = product
            }
        }

        return cheapestProduct
    }
}
