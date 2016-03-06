//
//  CreateOrderInteractorTests.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 05.03.2016.
//  Copyright © 2016 Suthananth Arulanatham. All rights reserved.
//

import XCTest
import UIKit

class CreateOrderInteractorTests: XCTestCase {
    
    //Subject under Test
    var createOrderInteractor: CreateOrderInteractor!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupCreateOrderInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //MARK: Setup
    func setupCreateOrderInteractor(){
        createOrderInteractor = CreateOrderInteractor()
    }

    //MARK: Test Doubles
    class CreateOderInteractorOutputSpy : CreateOrderInteractorOutput {
        var presentExpirationDateCalled = false
        func presentExpirationDate(response: CreateOrder_FormatExpirationDate_Response) {
            presentExpirationDateCalled = true
        }
        func presentSomething(response: CreateOrderResponse) {
        }
    }
    
    //MARK: Test Expiration Dates
    func testFormatExpirationDateShouldAskPresenterToFormatExpirationDate(){
        
        let request = CreateOrder_FormatExpirationDate_Request(date: NSDate())
        let createOrderInteractorOutputSpy = CreateOderInteractorOutputSpy()
        createOrderInteractor.output = createOrderInteractorOutputSpy
        
        createOrderInteractor.formatExpirationDate(request)
        
        XCTAssert(createOrderInteractorOutputSpy.presentExpirationDateCalled,"Formatting an expiration date should ask presenter to do it")
    }
    
    //MARK: Test Shipping Methods
    func testShippingMethodsShouldReturnAllAvailableShippingMethods(){
        
        // Given
        let allAvailableShippingMethods = ["Standard Shipping", "Two-Day Shipping","One-Day Shipping"]
        
        // when
        let returnedShippingMethods = createOrderInteractor.shippingMethods
        
        //then
        XCTAssertEqual(returnedShippingMethods, allAvailableShippingMethods,"Shipping methods should list all available shipping methods")
    }
}
