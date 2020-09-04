//
//  ShowCharacterInteractorTests.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class ShowCharacterInteractorTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ShowCharacterInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupShowCharacterInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupShowCharacterInteractor() {
        sut = ShowCharacterInteractor()
    }
    
    // MARK: - Test doubles
    
    class ShowCharacterPresentationLogicSpy: ShowCharacterPresentationLogic {
        
        // MARK: Method call expectations
        
        var presentCharacterCalled = false
        var presentFavoriteCalled = false
        
        // MARK: Spied methods
        
        func presentFetchedCharacter(response: ShowCharacter.GetCharacter.Response) {
            presentCharacterCalled = true
        }
        
        func presentFavorite(response: ShowCharacter.ToggleFavoriteCharacter.Response) {
            presentFavoriteCalled = true
        }
    }
    
    class CharactersWorkerSpy: CharactersWorker {
        // MARK: Method call expectations
        
        var fetchCharacterCalled = false
        var toggleFavoriteCharacterCalled = false
        
        override func fetchCharacter(characterToFetch: Int, completionHandler: @escaping (Character?) -> Void) {
            fetchCharacterCalled = true
            completionHandler(Seeds.Characters.characters.first!)
        }
        
        override func toggleFavoriteCharacter(characterToFavorite: Int, completionHandler: @escaping (Bool?) -> Void) {
            toggleFavoriteCharacterCalled = true
            completionHandler(true)
        }
    }
    
    // MARK: - Tests
    
    func testGetCharacterShouldAskPresenterToFormatResult() {
        //Given
        let showCharacterPresentationLogicSpy = ShowCharacterPresentationLogicSpy()
        sut.presenter = showCharacterPresentationLogicSpy
        let workerSpy = CharactersWorkerSpy(charactersAPI: CharactersAPI())
        sut.worker = workerSpy
        sut.character = Seeds.Characters.characters.first!
        
        //When
        let request = ShowCharacter.GetCharacter.Request()
        sut.getCharacter(request: request)
        
        //Then
        XCTAssert(showCharacterPresentationLogicSpy.presentCharacterCalled, "GetCharacter() should ask presenter to format the character")
        XCTAssert(workerSpy.fetchCharacterCalled, "GetCharacter() should ask worker to fetch the character")
    }
    
    func testToggleFavoriteShouldAskPresenterToFormatResult() {
        //Given
        //Given
        let showCharacterPresentationLogicSpy = ShowCharacterPresentationLogicSpy()
        sut.presenter = showCharacterPresentationLogicSpy
        let workerSpy = CharactersWorkerSpy(charactersAPI: CharactersAPI())
        sut.worker = workerSpy
        sut.character = Seeds.Characters.characters.first!
        
        //When
        let request = ShowCharacter.ToggleFavoriteCharacter.Request()
        sut.toggleFavoriteCharacter(request: request)
        
        //Then
        XCTAssert(showCharacterPresentationLogicSpy.presentFavoriteCalled, "ToggleFavorite() should ask presenter to format the favorite")
        XCTAssert(workerSpy.toggleFavoriteCharacterCalled, "ToggleFavorite() should ask worker to toggle the favorite character")
    }
}
