//
//  CharactersWorkerTests.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class CharactersWorkerTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: CharactersWorker!
    static var testCharacters: [Character]!
    
    //MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCharactersWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    func setupCharactersWorker() {
        sut = CharactersWorker(charactersAPI: CharactersAPISpy())
        
        CharactersWorkerTests.testCharacters = Seeds.Characters.characters
    }
    
    // MARK: - Test doubles
    class CharactersAPISpy: CharactersAPI {
        // MARK: - Method call expectations
        
        var fetchCharactersCalled = false
        var fetchCharacterCalled = false
        var toggleFavoriteCalled = false
        
        // MARK: - Spied methods
        
        override func fetchCharacters(isFirstPage: Bool, completionHandler: @escaping (() throws -> [Character]) -> Void) {
            fetchCharactersCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler { () -> [Character] in
                    return CharactersWorkerTests.testCharacters
                }
            }
        }
        
        override func fetchCharacter(id: Int, completionHandler: @escaping (() throws -> Character?) -> Void) {
            fetchCharacterCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler { () -> Character in
                    return CharactersWorkerTests.testCharacters.first!
                }
            }
        }
        
        override func toggleFavoriteCharacter(id: Int, completionHandler: @escaping (() throws -> Bool?) -> Void) {
            toggleFavoriteCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler { () -> Bool in
                    return true
                }
            }
        }
    }
    
    // MARK: - Tests
    
    func testFetchCharactersShouldReturnListOfCharacters() {
        //Given
        let charactersAPISpy = sut.charactersAPI as! CharactersAPISpy

        //When
        var fetchedCharacters = [Character]()
        sut.fetchCharacters(isFirstPage: true) { (characters) in
            fetchedCharacters = characters

            //Then
            XCTAssert(charactersAPISpy.fetchCharactersCalled, "Calling fetchCharacters() should ask the data store for a list of characters")
            XCTAssertEqual(fetchedCharacters.count, CharactersWorkerTests.testCharacters.count, "fetchCharacters() should return a list of characters")
            for character in fetchedCharacters {
                XCTAssert(CharactersWorkerTests.testCharacters.contains(character), "Feteched characters should match the characters in the data store")
            }
        }
    }
    
    func testFetchCharacterShouldReturnCharacter() {
        //Given
        let charactersAPISpy = sut.charactersAPI as! CharactersAPISpy
        
        //When
        var fetchedCharacter: Character?
        sut.fetchCharacter(characterToFetch: 1) { (character) in
            fetchedCharacter = character
            
            //Then
            XCTAssert(charactersAPISpy.fetchCharacterCalled, "Calling fetchCharacter() should ask the data store for a character")
            XCTAssertEqual(fetchedCharacter, CharactersWorkerTests.testCharacters.first!, "fetchCharacters() should match the character in the data store")
        }
    }
    
    func testToggleFavoriteCharacterShouldReturnFavorite() {
        //Given
        let charactersAPISpy = sut.charactersAPI as! CharactersAPISpy
        
        //When
        var fetchedFavorite: Bool?
        sut.toggleFavoriteCharacter(characterToFavorite: 1) { (favorite) in
            fetchedFavorite = favorite
            
            //Then
            XCTAssert(charactersAPISpy.toggleFavoriteCalled, "Calling toggleFavoriteCharacter() should ask the data store to update the existing character")
            XCTAssertEqual(fetchedFavorite, true, "Calling toggleFavoriteCharacter() should update the existing character")
        }
    }
}
