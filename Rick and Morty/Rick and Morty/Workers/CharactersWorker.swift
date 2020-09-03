//
//  CharactersWorker.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import Foundation

class CharactersWorker {
    var charactersAPI: CharactersProtocol
    
    init(charactersAPI: CharactersProtocol) {
        self.charactersAPI = charactersAPI
    }
    
    func fetchCharacters(isFirstPage: Bool, completionHandler: @escaping ([Character]) -> Void) {
        charactersAPI.fetchCharacters(isFirstPage: isFirstPage) { (characters: () throws -> [Character]) -> Void in
            do {
                let characters = try characters()
                DispatchQueue.main.async {
                    completionHandler(characters)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func fetchCharacter(characterToFetch: Int, completionHandler: @escaping (Character?) -> Void) {
        charactersAPI.fetchCharacter(id: characterToFetch) { (character: () throws -> Character?) -> Void in
            do {
                let character = try character()
                DispatchQueue.main.async {
                    completionHandler(character)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
}

protocol CharactersProtocol {
    func fetchCharacters(isFirstPage: Bool, completionHandler: @escaping (() throws -> [Character]) -> Void)
    func fetchCharacter(id: Int, completionHandler: @escaping (() throws -> Character?) -> Void)
}

enum APIError: Equatable, Error {
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotUpdate(String)
    case CannotDelete(String)
}

func ==(lhs: APIError, rhs: APIError) -> Bool
{
  switch (lhs, rhs) {
  case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
  case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
  case (.CannotUpdate(let a), .CannotUpdate(let b)) where a == b: return true
  case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
  default: return false
  }
}

