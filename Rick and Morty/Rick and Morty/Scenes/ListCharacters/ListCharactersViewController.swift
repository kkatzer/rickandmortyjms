//
//  ListCharactersViewController.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ListCharactersDisplayLogic: class {
    func displayFetchedCharacters(viewModel: ListCharacters.FetchCharacters.ViewModel)
}

class ListCharactersViewController: UICollectionViewController, ListCharactersDisplayLogic, UICollectionViewDelegateFlowLayout {
    var interactor: ListCharactersBusinessLogic?
    var router: (NSObjectProtocol & ListCharactersRoutingLogic & ListCharactersDataPassing)?
    
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
        let view = ListCharactersView()
        let interactor = ListCharactersInteractor()
        let presenter = ListCharactersPresenter()
        let router = ListCharactersRouter()
        view.dataSource = self
        viewController.collectionView = view
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        
        navigationItem.title = "Characters"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: Routing
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    //    {
    //        if let scene = segue.identifier {
    //            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
    //            if let router = router, router.responds(to: selector) {
    //                router.perform(selector, with: segue)
    //            }
    //        }
    //    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCharacters()
    }
    
    // MARK: Do something
    
    var displayedCharacters: [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter] = []
    
    func fetchCharacters() {
        let request = ListCharacters.FetchCharacters.Request()
        interactor?.fetchCharacters(request: request)
    }
    
    func displayFetchedCharacters(viewModel: ListCharacters.FetchCharacters.ViewModel) {
        displayedCharacters = viewModel.displayedCharacters
        collectionView.reloadData()
    }
    
    // MARK: - Collection view data source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedCharacters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayedCharacter = displayedCharacters[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath)
        
        guard let characterCell = cell as? ListCharactersViewCell else { return cell }
        characterCell.title.text = displayedCharacter.name
        characterCell.status.text = displayedCharacter.status
        characterCell.image.downloaded(from: displayedCharacter.image, contentMode: .scaleAspectFill)
        return characterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 49)/2
        let height = width * 1.34
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 17, bottom: 0, right: 17)
    }
}
