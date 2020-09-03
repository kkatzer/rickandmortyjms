//
//  CharactersAPITests.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class CharactersAPITests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: CharactersAPI!
    var testCharacters: [Character]!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCharactersAPI()
    }
    
    override func tearDown() {
        resetCharactersAPI()
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupCharactersAPI() {
        sut = CharactersAPI()
        testCharacters = Seeds.Characters.characters
    }
    
    func resetCharactersAPI() {
        CharactersAPI.characters = []
        sut = nil
    }
    
    //MARK: - Test operations
    
    func testFetchCharactersShouldReturnListOfOrders() {
        //Given
        
        //When
        var fetchedCharacters = [Character]()
        var fetchCharactersError: APIError?
        sut.fetchCharacters(isFirstPage: true) { (characters: () throws -> [Character]) -> Void in
            do {
                fetchedCharacters = try characters()
            } catch {
                fetchCharactersError = APIError.CannotFetch("Couldn't fetch")
            }
            
            //Then
            XCTAssertEqual(fetchedCharacters.count, self.testCharacters.count, "fetchCharacers() should return a list of characters")
            for character in fetchedCharacters {
                XCTAssert(self.testCharacters.contains(character), "Fetched characters should match the characters in the data store")
            }
            XCTAssertNil(fetchCharactersError, "fetchCharacters() should not return an error")
        }
        
    }
    
    func testFetchCharacterShouldReturnCharacter() {
        //Given
        let characterToFetch = testCharacters.first!
        CharactersAPI.characters = testCharacters
        
        //When
        var fetchedCharacter: Character?
        var fetchCharacterError: APIError?
        sut.fetchCharacter(id: characterToFetch.id) { (character: () throws -> Character?) -> Void in
            do {
                fetchedCharacter = try character()
            } catch {
                fetchCharacterError = APIError.CannotFetch("Couldn't fetch")
            }
            
            //Then
            XCTAssertEqual(fetchedCharacter, characterToFetch, "fetchCharacter() should return a character")
            XCTAssertNil(fetchCharacterError, "fetchCharacter() should not return an error")
        }
    }
    
    func testToggleFavoriteCharacterShouldReturnFavorite() {
        //Given
        let characterToFavorite = testCharacters.first!
        CharactersAPI.characters = testCharacters
        
        //When
        var returnedFavorite: Bool?
        var returnFavoriteError: APIError?
        sut.toggleFavoriteCharacter(id: characterToFavorite.id) { (favorite: () throws -> Bool?) -> Void in
            do {
                returnedFavorite = try favorite()
            } catch {
                returnFavoriteError = APIError.CannotUpdate("Couldn't update")
            }
            
            //Then
            XCTAssertNotEqual(returnedFavorite, characterToFavorite.favorite, "toggleFavorite() should return not current favorite")
            XCTAssertNil(returnFavoriteError, "toggleFavorite() should not return an error")
        }
    }
}

