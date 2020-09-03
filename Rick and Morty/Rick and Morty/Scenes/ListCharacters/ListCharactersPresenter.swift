//
//  ListCharactersPresenter.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ListCharactersPresentationLogic {
    func presentFetchedCharacters(response: ListCharacters.FetchCharacters.Response)
}

class ListCharactersPresenter: ListCharactersPresentationLogic {
    weak var viewController: ListCharactersDisplayLogic?
    
    // MARK: Do something
    
    func presentFetchedCharacters(response: ListCharacters.FetchCharacters.Response) {
        var displayedCharacters: [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter] = []
        for character in response.characters {
            let displayedCharacter = ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter(id: character.id, name: character.name, status: character.status, image: character.image)
            displayedCharacters.append(displayedCharacter)
        }
        let viewModel = ListCharacters.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters)
        viewController?.displayFetchedCharacters(viewModel: viewModel)
    }
}
