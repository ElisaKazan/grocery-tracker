//
//  Amount.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-09-07.
//

import Foundation

public class Amount: NSObject {
    public var quantity: Double
    public var unit: Unit

    init(quantity: Double, unit: Unit) {
        self.quantity = quantity
        self.unit = unit
    }

    public override var description: String {
        "\(quantity) \(unit)"
    }

    public enum Unit: CaseIterable, Identifiable, CustomStringConvertible {
        case milliliter
        case litre
        case gram
        case kilogram
        case unit

        public var id: Self { self }

        public var description: String {
            switch self {
            case .milliliter:
                return "ml"
            case .litre:
                return "l"
            case .gram:
                return "g"
            case .kilogram:
                return "kg"
            case .unit:
                return "unit"
            }
        }
    }

    // TODO: Compare Volume (ml and l) using Measurement

    // TODO: Compare Mass (g and kg) using Measurement
}
