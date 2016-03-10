//
//  ListOrderWorkerTests.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


@testable import CleanSwift
import XCTest

class ListOrderWorkerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListOrderWorker!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupListOrderWorker()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListOrderWorker(){
        sut = ListOrderWorker(ordersStore: OrdersMemStoreSpy())
    }
    
    // MARK: Test doubles
    
    
    
    class OrdersMemStoreSpy: OrdersMemStore{
        
        // MARK: Method call expectations
        var fetchedOrdersCalled = false
        
        
        // MARK: Spied Methods
        override func fetchOrders(completionHandler: (orders: [Order]) -> Void) {
            fetchedOrdersCalled = true
            let oneSecond = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
            dispatch_after(oneSecond, dispatch_get_main_queue()) { () -> Void in
                completionHandler(orders: [Order(), Order()])
            }
        }
    }
    
    // MARK: Tests
    func testFetchOrdersShouldReturnListOfOrders(){
        
        // Given
        let orderMemStoreSpy = sut.ordersStore as! OrdersMemStoreSpy
        
        // When
        let expectation = expectationWithDescription("Wait for fetched orders result")
        sut.fetchOrders { (orders) -> Void in
            expectation.fulfill()
        }
        
        //Then
        XCTAssert(orderMemStoreSpy.fetchedOrdersCalled, "Calling fetchOrders() should ask the data store for a list of orders")
        waitForExpectationsWithTimeout(1.1) { (error : NSError?) -> Void in
            XCTAssert(true, "Calling fetchOrders() should result in the completion handler being called with the fetched orders result")
        }
    }
}
