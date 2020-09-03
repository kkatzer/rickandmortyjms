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
        let destinationVC = ShowCharacterViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowCharacter(source: dataStore!, destination: &destinationDS)
        navigateToShowCharacter(source: viewController!, destination: destinationVC)
        
    }
    
    // MARK: Navigation
    
    func navigateToShowCharacter(source: ListCharactersViewController, destination: ShowCharacterViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToShowCharacter(source: ListCharactersDataStore, destination: inout ShowCharacterDataStore) {
        let selectedRow = viewController?.collectionView.indexPathsForSelectedItems?.first?.row
        destination.character = source.characters?[selectedRow!]
    }
}
