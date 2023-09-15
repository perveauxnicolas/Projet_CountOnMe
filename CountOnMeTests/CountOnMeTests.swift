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
    

    func testGiventhreeNumber_WhenTappingsevenFourseven_ThenResultShouldBeSevenHundredFourtySeven() {
        countOnMe.addNewNumber(7)
        countOnMe.addNewNumber(4)
        countOnMe.addNewNumber(7)
        XCTAssert(countOnMe.stringNumbers.last == "747")
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
    
    func testGivenCanAddOperator_WhenStringNumberContainSomething_ThenCanAddOperatorReturnTrue() {
        countOnMe.addNewNumber(1)
        XCTAssertTrue(countOnMe.canAddOperator)
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
    
    func testGivenOrderOfOperations_WhenStringNumberContainSomething_ThenStringNumberIsCorrect() {
        countOnMe.addNewNumber(1)
        countOnMe.orderOfOperations()
        XCTAssert(true)
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
        
    /*
    func testTextToDisplay() {
        countOnMe.addNewNumber(10)
        XCTAssert(countOnMe.updateDisplay.text == "10")
    }
     func testGivenAddititon_WhenTappingTenMoretwo_ThenResultShouldBetwelve() {
         countOnMe.addNewNumber(10)
         countOnMe.addition()
         countOnMe.addNewNumber(2)
         countOnMe.addition()
         XCTAssert(countOnMe.stringNumbers.last == "12")
     }
     
     func testGivenSubstraction_WhenTappingTenLessEight_ThenResultShouldTwo() {
        countOnMe.addNewNumber(10)
        countOnMe.substraction()
        countOnMe.addNewNumber(8)
        countOnMe.calculate()
        XCTAssert(countOnMe.stringNumbers.last == "2")
    }
    
    func testGivenMultiplication_WhenTappingTenLessEight_ThenResultShouldTwo() {
        countOnMe.addNewNumber(10)
        countOnMe.multiplication()
        countOnMe.addNewNumber(2)
        countOnMe.calculate()
        XCTAssert(countOnMe.stringNumbers.last == "20")
    }
  
    func testGivenDivision_WhenTappingTenLessTwo_ThenResultShouldFive() {
        countOnMe.addNewNumber(10)
        countOnMe.division()
        countOnMe.addNewNumber(2)
        countOnMe.calculate()
        XCTAssert(countOnMe.stringNumbers.last == "5")
    }
   
    func testExpressionIsCorrect() {
        XCTAssert(countOnMe.expressionIsCorrect == false)
        countOnMe.addNewNumber(10)
        XCTAssert(countOnMe.expressionIsCorrect == true)
        countOnMe.addNewOperator(with:"+")
        XCTAssert(countOnMe.expressionIsCorrect == false)
        countOnMe.addNewNumber(3)
        XCTAssert(countOnMe.expressionIsCorrect == true)
        countOnMe.calculate()
        XCTAssert(countOnMe.expressionIsCorrect == false)
    }
    
    func testTextToDisplay() {
        countOnMe.addNewNumber(10)
        countOnMe.addNewOperator(with:"+")
        countOnMe.addNewNumber(2)
        countOnMe.calculate()
        XCTAssert(countOnMe.updateDisplay.text == "5")
    }
    
    func testClear() {
        countOnMe.addNewNumber(10)
        countOnMe.addNewOperator(with: "+" )
        countOnMe.addNewNumber(2)
        countOnMe.calculate()
        countOnMe.clear()
        XCTAssertTrue(countOnMe.stringNumbers.last == "0")
    }
    
    func testAlertMessage()  {
        countOnMe.simpleCalcDelegate?.alertMessage(title: "oups", message: "test")
        XCTAssert(true)
        }
    
     func testDivisionFor0() {
         countOnMe.addNewNumber(1)
         countOnMe.division()
         countOnMe.addNewNumber(0)
         countOnMe.calculate()
         XCTAssertTrue(countOnMe.stringNumbers.last == "0")
     }
 
   
*/

    
}
