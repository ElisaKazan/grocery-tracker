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
    public func pricePerUnit(price: Double, amount: Amount) -> (Double, Amount) {
        let pricePerUnit: Double
        let quantity: Double

        switch amount.unit {
        case .milliliter, .gram:
            pricePerUnit = (price / amount.quantity) * 100
            quantity = 100
        case .litre, .kilogram, .unit:
            pricePerUnit = price / amount.quantity
            quantity = 1
        }

        return (pricePerUnit, Amount(quantity: quantity, unit: amount.unit))
    }

    // String representation of price per unit
    public func prettyPricePerUnit(price: Double, amount: Amount) -> String {
        let prettyPrice = priceFormatter.string(for: price)!
        let prettyQuantity = NumberFormatter().string(for: amount.quantity)!

        if amount.quantity == 1 {
            // No need to show quantity (ex: "$10 / kg")
            return "\(prettyPrice) / \(amount.unit.rawValue)"
        } else {
            return "\(prettyPrice) / \(prettyQuantity) \(amount.unit.rawValue)"
        }
    }
}
