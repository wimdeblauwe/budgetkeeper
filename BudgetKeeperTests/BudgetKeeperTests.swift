//
//  BudgetKeeperTests.swift
//  BudgetKeeperTests
//
//  Created by Wim Deblauwe on 02/05/16.
//  Copyright © 2016 Wim Deblauwe. All rights reserved.
//

import XCTest
@testable import BudgetKeeper

class BudgetKeeperTests: XCTestCase {
    
    func testBudgetItemInitialization_validArguments() {
        let item = BudgetItem(name: "Schoenen Jules", price: 200)
        XCTAssertNotNil(item)
    }
    
    func testBudgetItemInitialization_invalidDescription() {
        let item = BudgetItem(name: "", price: 200)
        XCTAssertNil(item, "empty description is invalid")
    }
    
    func testBudgetItemInitialization_invalidPrice() {
        let item = BudgetItem(name: "Schoenen Jules", price: -66)
        XCTAssertNil(item, "negative price is invalid")
    }
}
