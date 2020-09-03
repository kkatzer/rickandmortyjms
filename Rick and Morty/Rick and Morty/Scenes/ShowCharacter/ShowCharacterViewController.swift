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
        let view = ShowCharacterView()
        let interactor = ShowCharacterInteractor()
        let presenter = ShowCharacterPresenter()
        let router = ShowCharacterRouter()
        view.dataSource = self
        viewController.tableView = view
        viewController.tableView.tableFooterView = UIView()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        navigationItem.title = ""
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCharacter()
    }
    
    // MARK: Get character
    
    func getCharacter() {
        let request = ShowCharacter.GetCharacter.Request()
        interactor?.getCharacter(request: request)
    }
    
    var displayedCharacter: ShowCharacter.GetCharacter.ViewModel.DisplayedCharacter?
    
    func displayCharacter(viewModel: ShowCharacter.GetCharacter.ViewModel) {
        displayedCharacter = viewModel.displayedCharacter
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ShowCharacterHeaderView()
        guard let displayedCharacter = displayedCharacter else {
            return headerView
        }
        headerView.avatar.downloaded(from: displayedCharacter.image, contentMode: .scaleAspectFill)
        headerView.status.text = displayedCharacter.status
        headerView.name.text = displayedCharacter.name
        headerView.species.text = displayedCharacter.species
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath)
        guard let characterCell = cell as? ShowCharacterViewCell else { return cell }
        guard let displayedCharacter = displayedCharacter else { return cell }
        
        switch indexPath.row {
        case 0:
            characterCell.title.text = "Gender"
            characterCell.subtitle.text = displayedCharacter.gender
        case 1:
            characterCell.title.text = "Origin"
            characterCell.subtitle.text = displayedCharacter.origin
        case 2:
            characterCell.title.text = "Type"
            characterCell.subtitle.text = (displayedCharacter.type == "") ? "Unknown" : displayedCharacter.type
        case 3:
            characterCell.title.text = "Location"
            characterCell.subtitle.text = displayedCharacter.location
        default:
            print("Error on section switch case")
        }
        return characterCell
    }
}
