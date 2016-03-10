//
//  ListOrderInteractorTests.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


@testable import CleanSwift
import XCTest

class ListOrderInteractorTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListOrderInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupListOrderInteractor()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListOrderInteractor(){
        sut = ListOrderInteractor()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    
    func testFetchOrdersShouldAskOrdersWorkerToFetchOrdersAndPresenterToFormatResult(){
        
        // Given
        let listOrdersInteractorOutputSpy = ListOrdersInteractorOutoutSpy()
        sut.output = listOrdersInteractorOutputSpy
        let ordersWorkerSpy = OrdersWorkerSpy(ordersStore: OrdersMemStore())
        sut.worker = ordersWorkerSpy
        
        // When 
        let request = ListOrder_FetchOrders_Request()
        sut.fetchOrders(request)
        
        // Then
        XCTAssert(ordersWorkerSpy.fetchedOrdersCalled, "FetchOrders() should ask OrdersWorker to fetch order")
        XCTAssert(listOrdersInteractorOutputSpy.presentFetchedOrdersCalled, "FetchOrders() should ask presenter to format orders result")
    }
    
    
    class ListOrdersInteractorOutoutSpy: ListOrderInteractorOutput{
        
        // Mark: Method call expectations
        var presentFetchedOrdersCalled = false
        
        // MARK: Spied Methods
        func presentFetchedOrders(response: ListOrder_FetchOrders_Response){
            presentFetchedOrdersCalled = true
        }
        func presentSomething(response: ListOrderResponse) {
            
        }
    }
    
    class OrdersWorkerSpy: ListOrderWorker {
        
        // MARK: Method call expectations
        var fetchedOrdersCalled = false
        
        // MARK: Spied methods
        override func fetchOrders(completionHandler: (orders: [Order])->Void){
            fetchedOrdersCalled = true
            completionHandler(orders: [])
        }
    }
}
