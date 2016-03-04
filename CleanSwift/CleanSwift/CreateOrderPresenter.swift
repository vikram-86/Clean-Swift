//
//  CreateOrderPresenter.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 04.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol CreateOrderPresenterInput{
    
    func presentExpirationDate(response: CreateOrder_FormatExpirationDate_Response)
    func presentSomething(response: CreateOrderResponse)
}

protocol CreateOrderPresenterOutput: class{
    
    func displayExpirationDate(viewModel: CreateOrder_FormatExpirationDate_ViewModel)
    func displaySomething(viewModel: CreateOrderViewModel)
}

class CreateOrderPresenter: CreateOrderPresenterInput{
    weak var output: CreateOrderPresenterOutput!
    
    let dateFormatter : NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        return dateFormatter
    }()
    
    // MARK: Presentation logic
    
    func presentSomething(response: CreateOrderResponse){
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        
        let viewModel = CreateOrderViewModel()
        output.displaySomething(viewModel)
    }
    
    
    func presentExpirationDate(response: CreateOrder_FormatExpirationDate_Response) {
        let date = dateFormatter.stringFromDate(response.date)
        let viewModel = CreateOrder_FormatExpirationDate_ViewModel(date:date)
        output.displayExpirationDate(viewModel)
    }
}
