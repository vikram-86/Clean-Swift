//
//  ListOrderConfigurator.swift
//  CleanSwift
//
//  Created by Suthananth Arulanatham on 10.03.2016.
//  Copyright (c) 2016 Suthananth Arulanatham. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListOrderViewController: ListOrderPresenterOutput{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        router.passDataToNextScene(segue)
    }
}

extension ListOrderInteractor: ListOrderViewControllerOutput{
}

extension ListOrderPresenter: ListOrderInteractorOutput{
}

class ListOrderConfigurator{
    // MARK: Object lifecycle
    
    class var sharedInstance: ListOrderConfigurator{
        struct Static {
            static var instance: ListOrderConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ListOrderConfigurator()
        }
        
        return Static.instance!
    }
    
    // MARK: Configuration
    
    func configure(viewController: ListOrderViewController){
        let router = ListOrderRouter()
        router.viewController = viewController
        
        let presenter = ListOrderPresenter()
        presenter.output = viewController
        
        let interactor = ListOrderInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
