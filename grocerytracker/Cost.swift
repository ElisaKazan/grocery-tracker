//
//  Cost.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-09-07.
//

import Foundation

@objc(Cost)
public class Cost: NSObject, NSSecureCoding {
    public var price: Double
    public var quantity: Double
    public var unit: Unit

    init(price: Double, quantity: Double, unit: Unit) {
        self.price = price
        self.quantity = quantity
        self.unit = unit
    }

    public override var description: String {
        "Cost: \(price), \(quantity), \(unit)"
    }

    public var amountDescription: String {
        "\(quantity) \(unit)"
    }

    public enum Unit: String, CaseIterable, Identifiable {
        case milliliter = "ml"
        case litre = "L"
        case gram = "g"
        case kilogram = "kg"
        case unit = "unit"

        public var id: Self { self }
    }

    // TODO: Compare Volume (ml and l) using Measurement

    // TODO: Compare Mass (g and kg) using Measurement

    // NSCoding

    private enum CodingKeys: String {
        case price
        case quantity
        case unit
    }

    public required init?(coder: NSCoder) {
        price = coder.decodeDouble(forKey: CodingKeys.price.rawValue)
        quantity = coder.decodeDouble(forKey: CodingKeys.quantity.rawValue)
        let unitRawValue = coder.decodeObject(of: [Cost.self, NSString.self], forKey: CodingKeys.unit.rawValue) as? String ?? "unit"
        unit = Unit(rawValue: unitRawValue) ?? .unit
    }

    public func encode(with coder: NSCoder) {
        coder.encode(price, forKey: CodingKeys.price.rawValue)
        coder.encode(quantity, forKey: CodingKeys.quantity.rawValue)
        coder.encode(unit.rawValue, forKey: CodingKeys.unit.rawValue)
    }

    // NSSecureCoding
    public static var supportsSecureCoding: Bool = true
}

@objc(CostTransformer)
public class CostTransformer: ValueTransformer {

    override public func transformedValue(_ value: Any?) -> Any? {
        guard let cost = value as? Cost else { return nil }

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cost, requiringSecureCoding: true)
            return data
        } catch {
            assertionFailure("Failed to transform `Cost` to `Data`")
            return nil
        }
    }

    override public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }

        do {
            let cost = try NSKeyedUnarchiver.unarchivedObject(ofClass: Cost.self, from: data as Data)
            return cost
        } catch {
            assertionFailure("Failed to transform `Data` to `Cost`")
            return nil
        }
    }

    override public class func transformedValueClass() -> AnyClass {
        return Cost.self
    }

    override public class func allowsReverseTransformation() -> Bool {
        return true
    }
}
