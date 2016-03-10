//
//  CreateOrderViewController.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 04.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol CreateOrderViewControllerInput{
    
    func displayExpirationDate(viewModel: CreateOrder_FormatExpirationDate_ViewModel)
    func displaySomething(viewModel: CreateOrderViewModel)
}



protocol CreateOrderViewControllerOutput{
    
    var shippingMethods : [String]{get}
    func formatExpirationDate(request: CreateOrder_FormatExpirationDate_Request)
    func doSomething(request: CreateOrderRequest)
}



class CreateOrderViewController: UITableViewController, CreateOrderViewControllerInput, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    // MARK: Internal Properties
    
    var output: CreateOrderViewControllerOutput!
    var router: CreateOrderRouter!
    
    @IBOutlet weak var shippingMethodTextField: UITextField!
    @IBOutlet var shippingMethodPicker: UIPickerView!
    
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet var expirationDatePicker: UIDatePicker!
    
    // MARK: IBOutlets
    
    @IBOutlet var textFields: [UITextField]!
    
    
    // MARK: Object lifecycle
    
    override func awakeFromNib(){
        super.awakeFromNib()
        CreateOrderConfigurator.sharedInstance.configure(self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configure()
        doSomethingOnLoad()
    }
    
    // MARK: Event handling
    
    func doSomethingOnLoad(){
        // NOTE: Ask the Interactor to do some work
        
        let request = CreateOrderRequest()
        output.doSomething(request)
    }
    
    // MARK: Display logic
    
    func displaySomething(viewModel: CreateOrderViewModel){
        // NOTE: Display the result from the Presenter
        
        // nameTextField.text = viewModel.name
    }
    
    // MARK: UIDatePicker
    
    @IBAction func datePickerValueChanged(sender: AnyObject) {
        let date = expirationDatePicker.date
        let request = CreateOrder_FormatExpirationDate_Request(date : date)
        output.formatExpirationDate(request)
    }
    
    // MARK: TextField Delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if let index = textFields.indexOf(textField){
            
            if index < textFields.count - 1{
                
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
        }
        
        return true
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            
            for textField in textFields{
                
                if textField.isDescendantOfView(cell){
                    
                    textField.becomeFirstResponder()
                }
            }
        }
    }
    

    
    // MARK: UIPickerView Delegates
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return output.shippingMethods.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return output.shippingMethods[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        shippingMethodTextField.text = output.shippingMethods[row]
    }
    
    
    
    // MARK: ViewController Configurations
    func configure(){
        shippingMethodTextField.inputView = shippingMethodPicker
        expirationDateTextField.inputView = expirationDatePicker
    }
    
    // MARK: Input Protocols
    func displayExpirationDate(viewModel: CreateOrder_FormatExpirationDate_ViewModel) {
        let date = viewModel.date
        expirationDateTextField.text = date
    }
}