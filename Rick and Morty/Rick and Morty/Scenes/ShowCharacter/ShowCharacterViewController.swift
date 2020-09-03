//
//  ShowCharacterViewController.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ShowCharacterDisplayLogic: class {
    func displayCharacter(viewModel: ShowCharacter.GetCharacter.ViewModel)
}

class ShowCharacterViewController: UITableViewController, ShowCharacterDisplayLogic {
    var interactor: ShowCharacterBusinessLogic?
    var router: (NSObjectProtocol & ShowCharacterRoutingLogic & ShowCharacterDataPassing)?
    
    // MARK: Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ShowCharacterInteractor()
        let presenter = ShowCharacterPresenter()
        let router = ShowCharacterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        self.view.backgroundColor = .red
    }
    
    // MARK: View lifecycle
    
    
    
    // MARK: Do something
    
    func displayCharacter(viewModel: ShowCharacter.GetCharacter.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
