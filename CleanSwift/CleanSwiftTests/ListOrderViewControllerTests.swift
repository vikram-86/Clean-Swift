//
//  ListOrderViewControllerTests.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//

@testable import CleanSwift
import XCTest


class ListOrderViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListOrderViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupListOrderViewController()
    }
    
    override func tearDown(){
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListOrderViewController(){
        let bundle = NSBundle(forClass: self.dynamicType)
        
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewControllerWithIdentifier("ListOrderViewController") as! ListOrderViewController
        
    }
    
    func loadView(){
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    // MARK: Test doubles
    
    class ListOrderViewControllerOutputSpy: ListOrderViewControllerOutput {
        
        var fetchOrderCalled = false
        
        // MARK: Spied Method
        func fetchOrders(request: ListOrder_FetchOrders_Request){
            fetchOrderCalled = true
        }
        
        func doSomething(request: ListOrderRequest) {
            
        }
    }
    
    
    class TableViewSpy : UITableView {
        
        // MARK: Method call Expectations
        var reloadDataCalled = false
        
        // MARK: Spied Methods
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldFetchOrdersWhenViewIsLoaded(){
        // Given
        let listOrderViewControllerOutputSpy = ListOrderViewControllerOutputSpy()
        sut.output = listOrderViewControllerOutputSpy
        
        // When
        loadView()
        
        
        // Then
        XCTAssert(listOrderViewControllerOutputSpy.fetchOrderCalled,"Should fetch orders when view is loaded")
    }
    
    func testShouldDisplayFetchedOrders(){
        
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        let displayedOrders = [ListOrder_FetchOrders_ViewModel.DisplayedOrder(id: "abc123", date: "6/29/07", email: "amy.apple@cleanSwift.com", name: "Amy Apple", total: "$1.23")]
        let viewModel = ListOrder_FetchOrders_ViewModel(displayedOrders: displayedOrders)
        
        // When
        sut.displayFetchedOrders(viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched orders should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne(){
        
        // Given
        let tableView = sut.tableView
        
        // When
        let numberOfSections = sut.numberOfSectionsInTableView(tableView)
        
        
        // Then
        XCTAssertEqual(numberOfSections, 1,"The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInAnySextionShouldEqualNumberOfOrdersToDisplay(){
        
        // Given
        let tableView = sut.tableView
        let testDisplayedOrders = [ListOrder_FetchOrders_ViewModel.DisplayedOrder(id: "abs123", date: "6/29/07", email:  "amy.apple@cleanSwift.com", name: "Amy Apple", total: "$1.23")]
        sut.displayedOrders = testDisplayedOrders
        
        // When
        let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedOrders.count, "The number of table view rows should equal the number of to display")
        
    }
}













