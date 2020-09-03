//
//  ListCharactersInteractor.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ListCharactersBusinessLogic {
    func fetchCharacters(request: ListCharacters.FetchCharacters.Request)
}

protocol ListCharactersDataStore {
    var characters: [Character]? { get }
}

class ListCharactersInteractor: ListCharactersBusinessLogic, ListCharactersDataStore {
    var presenter: ListCharactersPresentationLogic?
    
    var worker = CharactersWorker(charactersAPI: CharactersAPI())
    var characters: [Character]?
    
    // MARK: - Fetch characters
    func fetchCharacters(request: ListCharacters.FetchCharacters.Request) {
        worker.fetchCharacters(isFirstPage: request.isFirstPage) { (characters) -> Void in
            self.characters = characters
            let response = ListCharacters.FetchCharacters.Response(characters: characters)
            self.presenter?.presentFetchedCharacters(response: response)
        }
    }
}
