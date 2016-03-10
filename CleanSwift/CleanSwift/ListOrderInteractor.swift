//
//  ListOrderInteractor.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol ListOrderInteractorInput{
    func doSomething(request: ListOrderRequest)
    func fetchOrders(request: ListOrder_FetchOrders_Request)
}

protocol ListOrderInteractorOutput{
    func presentSomething(response: ListOrderResponse)
    func presentFetchedOrders(response: ListOrder_FetchOrders_Response)
}

class ListOrderInteractor: ListOrderInteractorInput{
    var output: ListOrderInteractorOutput!
    var worker: ListOrderWorker!
    
    // MARK: Business logic
    
    func doSomething(request: ListOrderRequest){
        // NOTE: Create some Worker to do the work
        
        worker = ListOrderWorker(ordersStore: OrdersMemStore())
        worker.doSomeWork()
        
        // NOTE: Pass the result to the Presenter
        
        let response = ListOrderResponse()
        output.presentSomething(response)
    }
    
    func fetchOrders(request: ListOrder_FetchOrders_Request) {
        worker.fetchOrders { (orders) -> Void in
            let response = ListOrder_FetchOrders_Response(orders: orders)
            self.output.presentFetchedOrders(response)
        }
    }
}
