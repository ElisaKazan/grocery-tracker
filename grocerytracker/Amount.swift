//
//  Amount.swift
//  grocerytracker
//
//  Created by Elisa Kazan on 2024-09-07.
//

import Foundation

@objc(Amount)
public class Amount: NSObject, NSSecureCoding {
    public var quantity: Double
    public var unit: Unit

    init(quantity: Double, unit: Unit) {
        self.quantity = quantity
        self.unit = unit
    }

    public override var description: String {
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
        case quantity
        case unit
    }

    public required init?(coder: NSCoder) {
        quantity = coder.decodeDouble(forKey: CodingKeys.quantity.rawValue)
        let unitRawValue = coder.decodeObject(of: [Amount.self, NSString.self], forKey: CodingKeys.unit.rawValue) as? String ?? "unit"
        unit = Unit(rawValue: unitRawValue) ?? .unit
    }

    public func encode(with coder: NSCoder) {
        coder.encode(quantity, forKey: "quantity")
        coder.encode(unit.rawValue, forKey: "unit")
    }

    // NSSecureCoding
    public static var supportsSecureCoding: Bool = true
}

@objc(AmountTransformer)
public class AmountTransformer: ValueTransformer {

    override public func transformedValue(_ value: Any?) -> Any? {
        guard let amount = value as? Amount else { return nil }

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: amount, requiringSecureCoding: true)
            return data
        } catch {
            assertionFailure("Failed to transform `Amount` to `Data`")
            return nil
        }
    }

    override public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }

        do {
            let amount = try NSKeyedUnarchiver.unarchivedObject(ofClass: Amount.self, from: data as Data)
            return amount
        } catch {
            assertionFailure("Failed to transform `Data` to `Amount`")
            return nil
        }
    }

    override public class func transformedValueClass() -> AnyClass {
        return Amount.self
    }

    override public class func allowsReverseTransformation() -> Bool {
        return true
    }
}
