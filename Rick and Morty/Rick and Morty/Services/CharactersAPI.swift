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
    
    let info: Info
    let results: [Character]
}

class CharactersAPI: CharactersProtocol {
    private let decoder = Decoder()
    
    static var url = "https://rickandmortyapi.com/api/character/"
    
    var page: Int = 1
    
    static var characters: [Character] = []
    
    static var favorites: [Int] = []
    
    func fetchCharacters(isFirstPage: Bool, completionHandler: @escaping (() throws -> [Character]) -> Void) {
        if (isFirstPage) {
            page = 1
            type(of: self).characters = []
        }
        
        if (page == 0) {
            completionHandler { return type(of: self).characters }
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
                        type(of: self).characters.append(Character(id: char.id, name: char.name, status: char.status, species: char.species, type: char.type, gender: char.gender, origin: char.origin.name, location: char.location.name, image: char.image, favorite: type(of: self).favorites.contains(char.id)))
                    }
                    completionHandler { return type(of: self).characters }
                } catch let error {
                    completionHandler { throw APIError.CannotFetch(error.localizedDescription) }
                }
            case .failure(let error):
                completionHandler { throw APIError.CannotFetch(error.localizedDescription) }
            }
        }
    }
    
    func fetchCharacter(id: Int, completionHandler: @escaping (() throws -> Character?) -> Void) {
        if let index = indexOfCharacterWithID(id: id) {
            completionHandler { return type(of: self).characters[index] }
        } else {
            completionHandler { throw APIError.CannotFetch("Character with id \(id) not found") }
        }
    }
    
    func toggleFavoriteCharacter(id: Int, completionHandler: @escaping (() throws -> Bool?) -> Void) {
        if let index = type(of: self).favorites.firstIndex(of: id) {
            type(of: self).favorites.remove(at: index)
            completionHandler { return false }
        } else {
            type(of: self).favorites.append(id)
            completionHandler { return true }
        }
    }
    
    // MARK: - Convenience methods
    
    private func indexOfCharacterWithID(id: Int?) -> Int? {
        return type(of: self).characters.firstIndex { return $0.id == id }
    }
}
