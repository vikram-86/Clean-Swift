//
//  ListOrderPresenterTests.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//

@testable import CleanSwift
import XCTest

class ListOrderPresenterTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListOrderPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupListOrderPresenter()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListOrderPresenter(){
        sut = ListOrderPresenter()
    }
    
    // MARK: Test doubles
    class ListOrderPresenterOutputSpy: ListOrderPresenterOutput{
        
        // MARK: Method call expectations
        var displayFetchedOrdersCalled = false
        
        //MARK: Argument expectations
        var listOrdersFetchOrdersViewModel : ListOrder_FetchOrders_ViewModel!
        
        //MARK: Spied methods
        func displayFetchedOrders(viewModel: ListOrder_FetchOrders_ViewModel) {
            displayFetchedOrdersCalled = true
            listOrdersFetchOrdersViewModel = viewModel
        }
        
        func displaySomething(viewModel: ListOrderViewModel) {

        }
    }
    
    // MARK: Tests
    
    func testPresentFetchedOrdersShouldFormatFetchedOrdersForDisplay(){
        
        // Given
        let listOrdersPresenterOutputSpy = ListOrderPresenterOutputSpy()
        sut.output = listOrdersPresenterOutputSpy
        
        let dateComponents = NSDateComponents()
        dateComponents.year = 2007
        dateComponents.month = 6
        dateComponents.day = 29
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents)
        let orders = [Order(id: "abc123", date: date, email: "Vikram.sh86@gmail.com", firstName: "Vikram", lastName: "Arul", total: NSDecimalNumber(string: "1.23"))]
        let response = ListOrder_FetchOrders_Response(orders: orders)
        
        // When
        sut.presentFetchedOrders(response)
        
        
        // Then
        let displayedOrders = listOrdersPresenterOutputSpy.listOrdersFetchOrdersViewModel.displayedOrders
        for displayedOrder in displayedOrders {
            XCTAssertEqual(displayedOrder.id, "abc123","Presenting fetched orders should format order ID")
            XCTAssertEqual(displayedOrder.date,"6/29/07", "Presenting fetched orders should properly format order date")
            XCTAssertEqual(displayedOrder.email, "Vikram.sh86@gmail.com","Presenting fetched orders should properly format email")
            XCTAssertEqual(displayedOrder.name, "Vikram Arul","Presenting fetched orders should properly format name")
            XCTAssertEqual(displayedOrder.total, "$1.23", "Presenting fetched orders should properly format total")
        }
    }
    
    func testPresentFetchedOrdersShouldAskViewControllerToDisplayFetchedOrders(){
        
        // Given
        let listOrdersPresenterOutputSpy = ListOrderPresenterOutputSpy()
        sut.output = listOrdersPresenterOutputSpy
        let orders = [Order(id: "abs123", date : NSDate(), email: "amy.apple@cleanSwift.com",firstName: "Amy", lastName:"Apple", total: NSDecimalNumber(string: "1.23"))]
        let response = ListOrder_FetchOrders_Response(orders: orders)
        
        // When
        sut.presentFetchedOrders(response)
        
        // Then 
        XCTAssert(listOrdersPresenterOutputSpy.displayFetchedOrdersCalled, "Presenting fetched orders should ask view controller to display them")
        
    }
}
