//
//  PriceHelperTests.swift
//  grocerytrackerTests
//
//  Created by Elisa Kazan on 2024-09-10.
//

import XCTest
@testable import grocerytracker

final class PriceHelperTests: XCTestCase {

    // MARK: - Price Per Unit

    func testPricePerUnitKilogram() {
        let priceHelper = PriceHelper()

        let price = 12.99
        let amount = Amount(quantity: 1.81, unit: .kilogram)

        let expectedPrice = 7.176795580110497
        let expectedQuanity = 1.0
        let expectedUnit = Amount.Unit.kilogram

        let pricePerUnit = priceHelper.pricePerUnit(price: price, amount: amount)

        XCTAssertEqual(pricePerUnit.0, expectedPrice)
        XCTAssertEqual(pricePerUnit.1.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.1.unit, expectedUnit)
    }

    func testPricePerUnitGram() {
        let priceHelper = PriceHelper()

        let price = 10.89
        let amount = Amount(quantity: 700, unit: .gram)

        let expectedPrice = 1.5557142857142858
        let expectedQuanity = 100.0
        let expectedUnit = Amount.Unit.gram

        let pricePerUnit = priceHelper.pricePerUnit(price: price, amount: amount)

        XCTAssertEqual(pricePerUnit.0, expectedPrice)
        XCTAssertEqual(pricePerUnit.1.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.1.unit, expectedUnit)
    }

    func testPricePerUnitLitre() {
        let priceHelper = PriceHelper()

        let price = 5.99
        let amount = Amount(quantity: 1.9, unit: .litre)

        let expectedPrice = 3.1526315789473687
        let expectedQuanity = 1.0
        let expectedUnit = Amount.Unit.litre

        let pricePerUnit = priceHelper.pricePerUnit(price: price, amount: amount)

        XCTAssertEqual(pricePerUnit.0, expectedPrice)
        XCTAssertEqual(pricePerUnit.1.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.1.unit, expectedUnit)
    }

    func testPricePerUnitMillillitre() {
        let priceHelper = PriceHelper()

        let price = 16.99
        let amount = Amount(quantity: 473, unit: .milliliter)

        let expectedPrice = 3.591966173361522
        let expectedQuanity = 100.0
        let expectedUnit = Amount.Unit.milliliter

        let pricePerUnit = priceHelper.pricePerUnit(price: price, amount: amount)

        XCTAssertEqual(pricePerUnit.0, expectedPrice)
        XCTAssertEqual(pricePerUnit.1.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.1.unit, expectedUnit)
    }

    func testPricePerUnitUnit() {
        let priceHelper = PriceHelper()

        let price = 39.99
        let amount = Amount(quantity: 30, unit: .unit)

        let expectedPrice = 1.333
        let expectedQuanity = 1.0
        let expectedUnit = Amount.Unit.unit

        let pricePerUnit = priceHelper.pricePerUnit(price: price, amount: amount)

        XCTAssertEqual(pricePerUnit.0, expectedPrice)
        XCTAssertEqual(pricePerUnit.1.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.1.unit, expectedUnit)
    }

    // MARK: - Pretty Price Per Unit

    func testPrettyPricePerUnitKilogram() {
        let priceHelper = PriceHelper()

        let price = 7.176795580110497
        let amount = Amount(quantity: 1.0, unit: .kilogram)

        let prettyText = priceHelper.prettyPricePerUnit(price: price, amount: amount)

        XCTAssertEqual(prettyText, "$7.18 / kg")
    }

    func testPrettyPricePerUnitGram() {
        let priceHelper = PriceHelper()

        let price = 1.5557142857142858
        let amount = Amount(quantity: 100, unit: .gram)

        let prettyText = priceHelper.prettyPricePerUnit(price: price, amount: amount)

        XCTAssertEqual(prettyText, "$1.56 / 100 g")
    }

    func testPrettyPricePerUnitLitre() {
        let priceHelper = PriceHelper()

        let price = 3.1526315789473687
        let amount = Amount(quantity: 1.0, unit: .litre)

        let prettyText = priceHelper.prettyPricePerUnit(price: price, amount: amount)

        XCTAssertEqual(prettyText, "$3.15 / L")
    }

    func testPrettyPricePerUnitMillillitre() {
        let priceHelper = PriceHelper()

        let price = 3.591966173361522
        let amount = Amount(quantity: 100.0, unit: .milliliter)

        let prettyText = priceHelper.prettyPricePerUnit(price: price, amount: amount)

        XCTAssertEqual(prettyText, "$3.59 / 100 ml")
    }

    func testPrettyPricePerUnitUnit() {
        let priceHelper = PriceHelper()

        let price = 1.333
        let amount = Amount(quantity: 1.0, unit: .unit)

        let prettyText = priceHelper.prettyPricePerUnit(price: price, amount: amount)

        XCTAssertEqual(prettyText, "$1.33 / unit")
    }

}
