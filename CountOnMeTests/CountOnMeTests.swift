//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Perveaux Nicolas on 05/09/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import XCTest


@testable import CountOnMe


class SimpleCalcTests: XCTestCase {
    
    //MARK: - PROPERTIES
    var countOnMe: SimpleCalc!
    
    //MARK: - METHODS
    override func setUp() {
        super.setUp()
        countOnMe = SimpleCalc()
    }
    
    func testGivenIsExpressionCorrect_WhenExpressionTappedIsNotCorrect_ThenExpressionReturnFalse() {
        countOnMe.addNewNumber(1)
        countOnMe.addition()
        countOnMe.calculate()
        XCTAssertFalse(countOnMe.expressionIsCorrect)
    }
    
    func testGivenIsExpressionCorrect_WhenExpressionTappedIsCorrect_ThenExpressionReturnTrue() {
        countOnMe.addNewNumber(1)
        countOnMe.addition()
        countOnMe.addNewNumber(1)
        countOnMe.calculate()
        XCTAssertTrue(countOnMe.expressionIsCorrect)
    }
    
    func testGivenerror_WrongExpression(){
        countOnMe.addNewOperator(with: "+")
        countOnMe.simpleCalcDelegate?.alertMessage(title: "error", message: "Wrong expression!")
        XCTAssert(true)
    }
    
    func testGivenStartAnewCalculation(){
        countOnMe.calculate()
        countOnMe.simpleCalcDelegate?.alertMessage(title: "error!", message: "Start a new calculation!")
        XCTAssert(true)
    }
    
    func testGivenCanAddOperator_WhenStringNumberContainSomething_ThenCanAddOperatorReturnTrue() {
        countOnMe.addNewNumber(1)
        XCTAssertTrue(countOnMe.canAddOperator)
    }
    
    func testGiventhreeNumber_WhenTappingsevenFourseven_ThenResultShouldBeSevenHundredFourtySeven() {
        countOnMe.addNewNumber(7)
        countOnMe.addNewNumber(4)
        countOnMe.addNewNumber(7)
        XCTAssert(countOnMe.stringNumbers.last == "747")
    }
    
    func testGivenOperators_WhenTappingOperators_ThenfunctionOperator() {
        countOnMe.addNewOperator(with: "+")
        countOnMe.addition()
        countOnMe.addNewOperator(with: "-")
        countOnMe.substraction()
        countOnMe.addNewOperator(with: "x")
        countOnMe.multiplication()
        countOnMe.addNewOperator(with: "÷")
        countOnMe.substraction()
        countOnMe.addNewOperator(with: "AC")
        countOnMe.clear()
        XCTAssert(true)
    }
    
    func testGivenOrderOfOperations_WhenStringNumberContainSomething_ThenStringNumberFollowsOrderOfOperations() {
        countOnMe.addNewNumber(1)
        countOnMe.substraction()
        countOnMe.addNewNumber(2)
        countOnMe.multiplication()
        countOnMe.addNewNumber(8)
        countOnMe.division()
        countOnMe.addNewNumber(2)
        countOnMe.calculate()
        XCTAssert(true)
    }
  
    func testGivenOrderOfOperations_WhenTappingEightSubFourMultTwoAddOne_ThenResultShouldBeOne() {
        countOnMe.addNewNumber(8)
        countOnMe.substraction()
        countOnMe.addNewNumber(4)
        countOnMe.multiplication()
        countOnMe.addNewNumber(2)
        countOnMe.addition()
        countOnMe.addNewNumber(1)
        countOnMe.calculate()
        XCTAssert(countOnMe.stringNumbers.last == "1")
    }
        
    func testGivenAddititon_WhenTappingTenMoreFive_ThenResultShouldBefifteen() {
        countOnMe.addNewNumber(10)
        countOnMe.addition()
        countOnMe.addNewNumber(5)
        countOnMe.calculate()
        XCTAssert(countOnMe.stringNumbers.last == "15")
    }
    
    func testDivisionFor0_WhenTappingOneDivideZero_ThenResultShouldBeZero() {
        countOnMe.addNewNumber(1)
        countOnMe.division()
        countOnMe.addNewNumber(0)
        countOnMe.calculate()
        XCTAssertTrue(countOnMe.stringNumbers.last == "0")
    }
    
    func testmultiplication_WhenTappingfiveMultiplicateFive_ThenResultShouldBetwentyFive() {
        countOnMe.addNewNumber(5)
        countOnMe.multiplication()
        countOnMe.addNewNumber(5)
        countOnMe.calculate()
        XCTAssertTrue(countOnMe.stringNumbers.last == "25")
    }
    
    func testDivision_WhenTappingTenDivideTree_ThenResultShouldBeTreePointthritytree() {
        countOnMe.addNewNumber(10)
        countOnMe.division()
        countOnMe.addNewNumber(3)
        countOnMe.calculate()
        XCTAssertTrue(countOnMe.stringNumbers.last == "3.33")
    }
    
    func testGivenClear_WhenTappingAc_ThenResultShouldBeClerArrayOfNumber() {
        countOnMe.addNewNumber(10)
        countOnMe.clear()
        XCTAssertTrue(countOnMe.stringNumbers == [String()])
    }
    
}
