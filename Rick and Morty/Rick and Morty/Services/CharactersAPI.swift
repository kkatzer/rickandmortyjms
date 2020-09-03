//
//  CharactersAPI.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import Foundation

struct CharacterListCodable: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    struct Character: Codable {
        let id: Int
        let name: String
        let status: String
        let image: String
    }
    
    let info: Info
    let results: [Character]
}

struct CharacterCodable: Codable {
    struct CharacterLocation: Codable {
        let name: String
        let url: String
    }
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterLocation
    let location: CharacterLocation
    let image: String
}

class CharactersAPI: CharactersProtocol {
    private let decoder = Decoder()
    
    static var url = "https://rickandmortyapi.com/api/character/"
    
    var page: Int = 1
    
    var characters: [Character] = []
    
    func fetchCharacters(isFirstPage: Bool, completionHandler: @escaping (() throws -> [Character]) -> Void) {
        if (isFirstPage) {
            page = 1
            characters = []
        }
        
        if (page == 0) {
            completionHandler { return self.characters }
            return
        }
        
        decoder.loadJson(fromURLString: CharactersAPI.url + "?page=\(page)") { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(CharacterListCodable.self, from: data)
                    if let next = decodedData.info.next {
                        if let page = Int(String(next.suffix(1))) {
                            self.page = page
                        } else {
                            self.page = 0
                        }
                    } else {
                        self.page = 0
                    }
                    for char in decodedData.results {
                        self.characters.append(Character(id: char.id, name: char.name, status: char.status, image: char.image, favorite: false))
                    }
                    completionHandler { return self.characters }
                } catch let error {
                    completionHandler { throw APIError.CannotFetch(error.localizedDescription) }
                }
            case .failure(let error):
                completionHandler { throw APIError.CannotFetch(error.localizedDescription) }
            }
        }
    }
    
    func fetchCharacter(id: Int, completionHandler: @escaping (() throws -> Character?) -> Void) {
        decoder.loadJson(fromURLString: CharactersAPI.url + String(id)) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(CharacterCodable.self, from: data)
                    let character = Character(id: decodedData.id, name: decodedData.name, status: decodedData.status, species: decodedData.species, type: decodedData.type, gender: decodedData.gender, origin: decodedData.origin.name, location: decodedData.location.name, image: decodedData.image, favorite: false)
                    completionHandler { return character }
                } catch let error {
                    completionHandler { throw APIError.CannotFetch(error.localizedDescription) }
                }
            case .failure(let error):
                completionHandler { throw APIError.CannotFetch(error.localizedDescription) }
            }
        }
    }
}
