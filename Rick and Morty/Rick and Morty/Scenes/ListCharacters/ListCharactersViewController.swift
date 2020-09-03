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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selector = NSSelectorFromString("routeToShowCharacter")
        if let router = router, router.responds(to: selector) {
            router.perform(selector)
        }
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCharacters(isFirstPage: true)
    }
    
    // MARK: Do something
    
    var displayedCharacters: [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter] = []
    
    func fetchCharacters(isFirstPage: Bool) {
        let request = ListCharacters.FetchCharacters.Request(isFirstPage: isFirstPage)
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
        characterCell.favoriteIcon.isHidden = !displayedCharacter.favorite
        return characterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = (collectionView.frame.width - 49)/2
        if (width > 200) {
            width = (collectionView.frame.width - 66)/3
        }
        let height = width * 1.34
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 17, bottom: 0, right: 17)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == displayedCharacters.count - 1) {
            self.fetchCharacters(isFirstPage: false)
        }
    }
    
    //So the layout will be redrawn on rotate
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.invalidateLayout()
    }
}
