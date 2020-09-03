//
//  ShowCharacterInteractor.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ShowCharacterBusinessLogic {
    func getCharacter(request: ShowCharacter.GetCharacter.Request)
}

protocol ShowCharacterDataStore {
    var character: Character! { get set }
}

class ShowCharacterInteractor: ShowCharacterBusinessLogic, ShowCharacterDataStore {
    var presenter: ShowCharacterPresentationLogic?
    
    var worker = CharactersWorker(charactersAPI: CharactersAPI())
    var character: Character!
    
    // MARK: - Fetch characters
    func getCharacter(request: ShowCharacter.GetCharacter.Request) {
        worker.fetchCharacter(characterToFetch: character.id) { (character) -> Void in
            guard let character = character else { return }
            self.character = character
            let response = ShowCharacter.GetCharacter.Response(character: character)
            self.presenter?.presentFetchedCharacter(response: response)
        }
    }
}
