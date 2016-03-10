//
//  ListOrderPresenter.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol ListOrderPresenterInput{
    func presentSomething(response: ListOrderResponse)
    func presentFetchedOrders(response: ListOrder_FetchOrders_Response)
}

protocol ListOrderPresenterOutput: class{
    func displaySomething(viewModel: ListOrderViewModel)
    func displayFetchedOrders(viewModel: ListOrder_FetchOrders_ViewModel)
}

class ListOrderPresenter: ListOrderPresenterInput{
    weak var output: ListOrderPresenterOutput!
  
    let dateFormatter : NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        return dateFormatter
    }()
    
    let currencyFormatter : NSNumberFormatter = {
       let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        return currencyFormatter
    }()
    
    // MARK: Presentation logic
    
    func presentSomething(response: ListOrderResponse){
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        
        let viewModel = ListOrderViewModel()
        output.displaySomething(viewModel)
    }
    
    func presentFetchedOrders(response: ListOrder_FetchOrders_Response) {
        
        var displayedOrders : [ListOrder_FetchOrders_ViewModel.DisplayedOrder] = []
        for order in response.orders {
            let date = dateFormatter.stringFromDate(order.date!)
            let total = currencyFormatter.stringFromNumber(order.total!)
            let displayedOrder = ListOrder_FetchOrders_ViewModel.DisplayedOrder(id: order.id!, date:  date, email: order.email!, name: "\(order.firstName!) \(order.lastName!)", total: total!)
            displayedOrders.append(displayedOrder)
        }
        let viewModel = ListOrder_FetchOrders_ViewModel(displayedOrders: displayedOrders)
        output.displayFetchedOrders(viewModel)
    }
}
