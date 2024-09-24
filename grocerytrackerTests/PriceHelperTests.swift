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
        let cost = Cost(price: 12.99, quantity: 1.81, unit: .kilogram)

        let expectedPrice = 7.176795580110497
        let expectedQuanity = 1.0
        let expectedUnit = Cost.Unit.kilogram

        let pricePerUnit = priceHelper.pricePerUnit(cost: cost)

        XCTAssertEqual(pricePerUnit.price, expectedPrice)
        XCTAssertEqual(pricePerUnit.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.unit, expectedUnit)
    }

    func testPricePerUnitGram() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 10.89, quantity: 700, unit: .gram)

        let expectedPrice = 1.5557142857142858
        let expectedQuanity = 100.0
        let expectedUnit = Cost.Unit.gram

        let pricePerUnit = priceHelper.pricePerUnit(cost: cost)

        XCTAssertEqual(pricePerUnit.price, expectedPrice)
        XCTAssertEqual(pricePerUnit.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.unit, expectedUnit)
    }

    func testPricePerUnitLitre() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 5.99, quantity: 1.9, unit: .litre)

        let expectedPrice = 3.1526315789473687
        let expectedQuanity = 1.0
        let expectedUnit = Cost.Unit.litre

        let pricePerUnit = priceHelper.pricePerUnit(cost: cost)

        XCTAssertEqual(pricePerUnit.price, expectedPrice)
        XCTAssertEqual(pricePerUnit.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.unit, expectedUnit)
    }

    func testPricePerUnitMillillitre() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 16.99, quantity: 473, unit: .milliliter)

        let expectedPrice = 3.591966173361522
        let expectedQuanity = 100.0
        let expectedUnit = Cost.Unit.milliliter

        let pricePerUnit = priceHelper.pricePerUnit(cost: cost)

        XCTAssertEqual(pricePerUnit.price, expectedPrice)
        XCTAssertEqual(pricePerUnit.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.unit, expectedUnit)
    }

    func testPricePerUnitUnit() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 39.99, quantity: 30, unit: .unit)

        let expectedPrice = 1.333
        let expectedQuanity = 1.0
        let expectedUnit = Cost.Unit.unit

        let pricePerUnit = priceHelper.pricePerUnit(cost: cost)

        XCTAssertEqual(pricePerUnit.price, expectedPrice)
        XCTAssertEqual(pricePerUnit.quantity, expectedQuanity)
        XCTAssertEqual(pricePerUnit.unit, expectedUnit)
    }

    // MARK: - Pretty Price Per Unit

    func testPrettyPricePerUnitKilogram() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 7.176795580110497, quantity: 1.0, unit: .kilogram)
        let prettyText = priceHelper.prettyPricePerUnit(cost: cost)

        XCTAssertEqual(prettyText, "$7.18 / kg")
    }

    func testPrettyPricePerUnitGram() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 1.5557142857142858, quantity: 100, unit: .gram)
        let prettyText = priceHelper.prettyPricePerUnit(cost: cost)

        XCTAssertEqual(prettyText, "$1.56 / 100 g")
    }

    func testPrettyPricePerUnitLitre() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 3.1526315789473687, quantity: 1.0, unit: .litre)
        let prettyText = priceHelper.prettyPricePerUnit(cost: cost)

        XCTAssertEqual(prettyText, "$3.15 / L")
    }

    func testPrettyPricePerUnitMillillitre() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 3.591966173361522, quantity: 100, unit: .milliliter)
        let prettyText = priceHelper.prettyPricePerUnit(cost: cost)

        XCTAssertEqual(prettyText, "$3.59 / 100 ml")
    }

    func testPrettyPricePerUnitUnit() {
        let priceHelper = PriceHelper()
        let cost = Cost(price: 1.333, quantity: 1.0, unit: .unit)
        let prettyText = priceHelper.prettyPricePerUnit(cost: cost)

        XCTAssertEqual(prettyText, "$1.33 / unit")
    }

    // MARK: - CheapestProduct

    func testCheapestProduct() {
        guard let moc = CoreDataContextBuilder.buildTestContext() else {
            assertionFailure("Building Managed Object Context failed")
            return
        }

        let priceHelper = PriceHelper()

        let productA = Product(context: moc)
        productA.pricePerUnit = Cost(price: 4.99, quantity: 1, unit: .gram)

        XCTAssertNotNil(productA.pricePerUnit)

        let productB = Product(context: moc)
        productB.pricePerUnit = Cost(price: 3.75, quantity: 1, unit: .gram)

        let productC = Product(context: moc)
        productC.pricePerUnit = Cost(price: 7.23, quantity: 1, unit: .gram)

        let cheapestProduct = priceHelper.cheapestProduct(products: [productA, productB, productC])

        XCTAssertEqual(cheapestProduct, productB)
    }

}
