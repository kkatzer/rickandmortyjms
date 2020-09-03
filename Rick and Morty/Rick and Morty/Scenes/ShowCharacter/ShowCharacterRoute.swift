//
//  ShowCharacterRoute.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

@objc protocol ShowCharacterRoutingLogic {
}

protocol ShowCharacterDataPassing {
    var dataStore: ShowCharacterDataStore? { get }
}

class ShowCharacterRouter: NSObject, ShowCharacterRoutingLogic, ShowCharacterDataPassing {
    weak var viewController: ShowCharacterViewController?
    var dataStore: ShowCharacterDataStore?
    
    // MARK: Routing
    
    // MARK: Navigation
    
//    func navigateToShowCharacter(source: ShowCharacterViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
//
//    // MARK: Passing data
//
//    func passDataToSomewhere(source: ShowCharacterDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
