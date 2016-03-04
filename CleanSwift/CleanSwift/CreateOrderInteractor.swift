//
//  CreateOrderInteractor.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 04.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol CreateOrderInteractorInput{
    
    var shippingMethods : [String]{get}
    func formatExpirationDate(request : CreateOrder_FormatExpirationDate_Request)
    func doSomething(request: CreateOrderRequest)
}

protocol CreateOrderInteractorOutput{
    
    func presentExpirationDate(response: CreateOrder_FormatExpirationDate_Response)
    func presentSomething(response: CreateOrderResponse)
}

class CreateOrderInteractor: CreateOrderInteractorInput{
    
    var output: CreateOrderInteractorOutput!
    var worker: CreateOrderWorker!
    
    var shippingMethods = ["Standard Shipping", "Two-day Shipping", "One-day Shipping"]
    
    // MARK: Business logic
    
    func doSomething(request: CreateOrderRequest){
        // NOTE: Create some Worker to do the work
        
        worker = CreateOrderWorker()
        worker.doSomeWork()
        
        // NOTE: Pass the result to the Presenter
        
        let response = CreateOrderResponse()
        output.presentSomething(response)
    }
    
    func formatExpirationDate(request: CreateOrder_FormatExpirationDate_Request) {
        let response = CreateOrder_FormatExpirationDate_Response(date: request.date)
        output.presentExpirationDate(response)
    }
}
