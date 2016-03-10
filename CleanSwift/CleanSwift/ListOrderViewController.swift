//
//  ListOrderViewController.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//


import UIKit

protocol ListOrderViewControllerInput{
    func displaySomething(viewModel: ListOrderViewModel)
    func displayFetchedOrders(viewModel: ListOrder_FetchOrders_ViewModel)
}

protocol ListOrderViewControllerOutput{
    func doSomething(request: ListOrderRequest)
    func fetchOrders(request: ListOrder_FetchOrders_Request)
}

class ListOrderViewController: UITableViewController, ListOrderViewControllerInput{
    var output: ListOrderViewControllerOutput!
    var router: ListOrderRouter!
    var displayedOrders : [ListOrder_FetchOrders_ViewModel.DisplayedOrder] = []
    
    // MARK: Object lifecycle
    
    override func awakeFromNib(){
        super.awakeFromNib()
        ListOrderConfigurator.sharedInstance.configure(self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        doSomethingOnLoad()
        fetchOrdersOnLoad()
    }
    
    
    func fetchOrdersOnLoad(){
        let request = ListOrder_FetchOrders_Request()
        output.fetchOrders(request)
    }
    
    // MARK: Event handling
    
    func doSomethingOnLoad(){
        // NOTE: Ask the Interactor to do some work
        
        let request = ListOrderRequest()
        output.doSomething(request)
    }
    
    // MARK: Display logic
    
    func displaySomething(viewModel: ListOrderViewModel){
        // NOTE: Display the result from the Presenter
        
        // nameTextField.text = viewModel.name
    }
    
    func displayFetchedOrders(viewModel: ListOrder_FetchOrders_ViewModel) {
        displayedOrders = viewModel.displayedOrders
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedOrders.count
    }
}
