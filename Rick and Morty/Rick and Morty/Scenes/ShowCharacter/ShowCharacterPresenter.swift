//
//  ShowCharacterPresenter.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ShowCharacterPresentationLogic {
    func presentFetchedCharacter(response: ShowCharacter.GetCharacter.Response)
}

class ShowCharacterPresenter: ShowCharacterPresentationLogic {
    weak var viewController: ShowCharacterDisplayLogic?
    
    // MARK: Do something
    
    func presentFetchedCharacter(response: ShowCharacter.GetCharacter.Response) {
        let character = response.character
        
        let displayedCharacter = ShowCharacter.GetCharacter.ViewModel.DisplayedCharacter(id: character.id, name: character.name, status: character.status, species: character.species, type: character.type, gender: character.gender, origin: character.origin, location: character.location, image: character.image, favorite: character.favorite)
        
        let viewModel = ShowCharacter.GetCharacter.ViewModel(displayedCharacter: displayedCharacter)
        viewController?.displayCharacter(viewModel: viewModel)
    }
}
