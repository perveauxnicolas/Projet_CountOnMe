//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest

@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    var simpleCalc: SimpleCalc!
    
    override func setUp() {
        super.setUp()
        simpleCalc = SimpleCalc()
    }

    func testGivenAddNumber_WhenAddNumber_ThenReturnNumber() {
          simpleCalc.addNumbers(numbers: "1")
          XCTAssertTrue(simpleCalc.CalcString == "1")
    }
    
    func testGivenCanAddOperator_WhenCanAddOperator_ThenReturnTrue() {
        simpleCalc.CalcString = " 1 + 1 + 1 "
        XCTAssertTrue(simpleCalc.canAddOperator)
    }
   

    
    
    
    
    
    
    
}
