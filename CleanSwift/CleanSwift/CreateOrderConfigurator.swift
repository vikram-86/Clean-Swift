//
//  CreateOrderConfigurator.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 04.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension CreateOrderViewController: CreateOrderPresenterOutput{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        router.passDataToNextScene(segue)
    }
}

extension CreateOrderInteractor: CreateOrderViewControllerOutput{
}

extension CreateOrderPresenter: CreateOrderInteractorOutput{
}

class CreateOrderConfigurator{
    // MARK: Object lifecycle
    
    class var sharedInstance: CreateOrderConfigurator{
        struct Static {
            static var instance: CreateOrderConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CreateOrderConfigurator()
        }
        
        return Static.instance!
    }
    
    // MARK: Configuration
    
    func configure(viewController: CreateOrderViewController){
        let router = CreateOrderRouter()
        router.viewController = viewController
        
        let presenter = CreateOrderPresenter()
        presenter.output = viewController
        
        let interactor = CreateOrderInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
