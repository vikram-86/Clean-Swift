//
//  ListOrderWorker.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol OrdersStoreProtocol {
    
    func fetchOrders(completionHandler: (orders: [Order])->Void)
}

class ListOrderWorker{
    // MARK: Business Logic
    var ordersStore : OrdersStoreProtocol
    
    init(ordersStore: OrdersStoreProtocol){
        self.ordersStore = ordersStore
    }
    func doSomeWork(){
        // NOTE: Do the work
    }
    
    func fetchOrders(completionHandler:(orders: [Order])->Void){
        ordersStore.fetchOrders { (orders) -> Void in
            completionHandler(orders: orders)
        }
    }
}
