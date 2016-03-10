//
//  CreateOrderPresenterTests.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 07.03.2016.
//  Copyright © 2016 Suthananth Arulanatham. All rights reserved.
//

import UIKit
import XCTest

class CreateOrderPresenterTests: XCTestCase {
    
    // Entity under Test
    class CreateOrderPresenterOutputSpy : CreateOrderPresenterOutput {
        
        //MARK: Method call expectations
        var displayExpirationDateCalled = false
        
        //MARK: Argument expectations
        var createOrder_formatExpirationDate_viewModel: CreateOrder_FormatExpirationDate_ViewModel!
        
        //MARK: Spied methods
        func displayExpirationDate(viewModel: CreateOrder_FormatExpirationDate_ViewModel) {
            displayExpirationDateCalled = true
            createOrder_formatExpirationDate_viewModel = viewModel
        }
        
        func displaySomething(viewModel: CreateOrderViewModel) {
            
        }
        
    }
    
    var createOrderPresenter : CreateOrderPresenter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupCreateOrderPresenter()
    }
    
    // MARK: Setup
    
    func setupCreateOrderPresenter(){
        createOrderPresenter = CreateOrderPresenter()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPresentExpirationDateShouldConvertDateToString(){
        // Given
        let createOrderPresenterOutputSpy = CreateOrderPresenterOutputSpy()
        createOrderPresenter.output = createOrderPresenterOutputSpy
        
        let dateComponents = NSDateComponents()
        dateComponents.year = 2007
        dateComponents.month = 6
        dateComponents.day = 29
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
        let response = CreateOrder_FormatExpirationDate_Response(date:date)
        
        // When
        createOrderPresenter.presentExpirationDate(response)
        
        // Then
        let returnedDate = createOrderPresenterOutputSpy.createOrder_formatExpirationDate_viewModel.date
        let expectedDate = "6/29/07"
        XCTAssertEqual(returnedDate, expectedDate,"Presenting an expriation date should convert date to string")
    }
    
    
    func testPresentExpirationDateShouldAskViewControllerToDisplayDateString(){
        //Given
        let createOrderPresenterOutputSpy = CreateOrderPresenterOutputSpy()
        createOrderPresenter.output = createOrderPresenterOutputSpy
        let response = CreateOrder_FormatExpirationDate_Response(date:NSDate())
        
        
        //When
        createOrderPresenter.presentExpirationDate(response)
        
        //Then
        XCTAssert(createOrderPresenterOutputSpy.displayExpirationDateCalled, "Presenting an expiration date should ask view controller to display date string")
    }
}
