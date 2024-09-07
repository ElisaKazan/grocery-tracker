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
}
