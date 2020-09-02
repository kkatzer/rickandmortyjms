//
//  ListCharactersRouter.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

@objc protocol ListCharactersRoutingLogic {
    func routeToShowCharacter()
}

protocol ListCharactersDataPassing {
    var dataStore: ListCharactersDataStore? { get }
}

class ListCharactersRouter: NSObject, ListCharactersRoutingLogic, ListCharactersDataPassing {
    weak var viewController: ListCharactersViewController?
    var dataStore: ListCharactersDataStore?
    
    // MARK: Routing
    
    func routeToShowCharacter() {
        //TODO
    }
    
    // MARK: Navigation
    
//    func navigateToShowCharacter(source: ListCharactersViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
//
//    // MARK: Passing data
//
//    func passDataToSomewhere(source: ListCharactersDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
