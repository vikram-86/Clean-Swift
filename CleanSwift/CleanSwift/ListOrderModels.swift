//
//  ListOrderModels.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

struct ListOrderRequest{
}

struct ListOrderResponse{
}

struct ListOrderViewModel{
}

struct ListOrder_FetchOrders_Request{
    
}

struct ListOrder_FetchOrders_Response{
    var orders : [Order]
}

struct ListOrder_FetchOrders_ViewModel{
    
    struct DisplayedOrder {
        var id      : String
        var date    : String
        var email   : String
        var name    : String
        var total   : String
    }
    
    var displayedOrders: [DisplayedOrder]
}

