//
//  CreateOrderViewControllerTests.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 09.03.2016.
//  Copyright © 2016 Suthananth Arulanatham. All rights reserved.
//

import XCTest

class CreateOrderViewControllerTests: XCTestCase {
    var createOrderViewController : CreateOrderViewController!
    var window : UIWindow!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        window = UIWindow()
        setupCreateOrderViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func setupCreateOrderViewController(){
        let bundle = NSBundle(forClass: self.dynamicType)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        createOrderViewController = storyboard.instantiateViewControllerWithIdentifier("CreateOrderViewController") as! CreateOrderViewController
        _ = createOrderViewController.view  // Calling view so that viewDidLoad is called and prepares viewcontroller to be tested.
        addViewToWindow()
    }
    
    func addViewToWindow(){
        window.addSubview(createOrderViewController.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    // Creating a Spy
    class CreateOrderViewControllerSpy : CreateOrderViewControllerOutput {
        
        // MARK: Method call expectations
        var formatExpirationDateCalled = false
        
        // MARK: Argument Expectations
        var createOrder_formatiExpirationDate_request : CreateOrder_FormatExpirationDate_Request!
        
        
        //MARK: Spied Variables
        var shippingMethods = [String]()
        
        func formatExpirationDate(request: CreateOrder_FormatExpirationDate_Request) {
            formatExpirationDateCalled = true
            createOrder_formatiExpirationDate_request = request
        }
        
        func doSomething(request: CreateOrderRequest) {
            
        }
        
    }
    
    func testDisplayExpirationDateShouldDisplayDateStringInTextField(){
        
        // Given
        let viewModel = CreateOrder_FormatExpirationDate_ViewModel(date: "6/29/07")
        
        // When
        createOrderViewController.displayExpirationDate(viewModel)
        
        // Then
        let displayDate = createOrderViewController.expirationDateTextField.text
        XCTAssertEqual(displayDate, "6/29/07", "Displaying an expiration date should display the date string in the expiration date text field")
    }
    
    func testExpirationDatePickerValueChangedShouldFormatSelectedDate(){
        
        // Given
        let createOrderViewControllerOutputSpy = CreateOrderViewControllerSpy()
        createOrderViewController.output = createOrderViewControllerOutputSpy
        
        let dateComponents = NSDateComponents()
        dateComponents.year = 2007
        dateComponents.month = 6
        dateComponents.day = 29
        let selectedDate = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
        
        // When
        createOrderViewController.expirationDatePicker.date = selectedDate
        createOrderViewController.datePickerValueChanged(self)
        
        // Then
        XCTAssert(createOrderViewControllerOutputSpy.formatExpirationDateCalled, "Changing the expiration date should format the expiration date")
        let actualDate = createOrderViewControllerOutputSpy.createOrder_formatiExpirationDate_request.date
        XCTAssertEqual(actualDate, selectedDate,"Changing the expiration date should format the date selected in the date picker")
        
    }
    
    func testNumberOfComponentsInPickerViewShouldReturnOneComponent(){
        
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker
        
        // When
        let numberOfComponents = createOrderViewController.numberOfComponentsInPickerView(pickerView)
        
        // Then
        XCTAssertEqual(numberOfComponents, 1,"The number of components in the shipping method picker should be 1")
    }
    
    func testNumberOfRowsInFirstComponentOfPickerViewShouldEqualNumberOfAvailableShippingMethods(){
        
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker
        
        // When
        let numberOfRows = createOrderViewController.pickerView(pickerView, numberOfRowsInComponent: 0)
        
        // Then
        let numberOfAvailableShippingMethods = createOrderViewController.output.shippingMethods.count
        XCTAssertEqual(numberOfRows, numberOfAvailableShippingMethods,"The number of rows in the first component of shipping method picker should equal to the number of available shippping methods")
    }
    
    func testShippingMethodPickerShouldDisplayProperTitles(){
        
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker
        
        // When
        let returnedTitles =
        [createOrderViewController.pickerView(pickerView, titleForRow: 0, forComponent: 0),
            createOrderViewController.pickerView(pickerView, titleForRow: 1, forComponent: 0),
            createOrderViewController.pickerView(pickerView, titleForRow: 2, forComponent: 0)]
        
        // Then
        var expectedTitles = ["Standard Shipping","Two-Day Shipping","One-Day Shipping"]
        for i in 0..<returnedTitles.count {
            XCTAssertEqual(returnedTitles[i], expectedTitles[i],"The shipping method picker should display proper titles")
        }
    }
    
    func testSelectingShippingMethodInThePickerShouldDisplayTheSelectedShippingMethodToUser(){
        
        // Given
        let pickerView = createOrderViewController.shippingMethodPicker
        
        // When
        createOrderViewController.pickerView(pickerView, didSelectRow: 1, inComponent: 0)
        
        // Then
        let expectedShippingMethod = "Two-Day Shipping"
        let displayedShippingMethod = createOrderViewController.shippingMethodTextField.text
        XCTAssertEqual(displayedShippingMethod, expectedShippingMethod, "Selecting a shipping method in the shipping method picker should display the selected shipping method to user")
    }
    
    func testCursorFocusShouldMoveToNextTextFieldWhenUserTapsReturnKey(){
        
        // Given 
        let currentTextField = createOrderViewController.textFields[0]
        let nextTextField = createOrderViewController.textFields[1]
        currentTextField.becomeFirstResponder()
        
        // When
        createOrderViewController.textFieldShouldReturn(currentTextField)
        
        // Then
        XCTAssert(!currentTextField.isFirstResponder(), "Current text field should lose keyboard focus")
        XCTAssert(nextTextField.isFirstResponder()," Next text field should gain keyboard focus")
    }
    
    func testKeyboardShouldBeDismissedWhenUserTapsReturnKeyWhenFocusIsInLastTextField(){
        // Given
        // Scroll to the bottom of the table view so the last text field is visible and its gesture recognizer is set up
        let lastSectionIndex = createOrderViewController.tableView.numberOfSections - 1
        let lastRowIndex = createOrderViewController.tableView.numberOfRowsInSection(lastSectionIndex) - 1
        createOrderViewController.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: lastRowIndex, inSection: lastSectionIndex), atScrollPosition: .Bottom, animated: false)
        
        // Show keyboard for the last textField
        let numTextFields = createOrderViewController.textFields.count
        let lastTextField = createOrderViewController.textFields[numTextFields - 1]
        lastTextField.becomeFirstResponder()
        
        // When
        createOrderViewController.textFieldShouldReturn(lastTextField)
        
        // Then
        XCTAssert(!lastTextField.isFirstResponder(),"Last text field should lose keyboard focus")
    }
}