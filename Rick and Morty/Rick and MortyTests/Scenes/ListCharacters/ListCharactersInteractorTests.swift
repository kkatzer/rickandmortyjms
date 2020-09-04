//
//  ListCharactersInteractorTests.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class ListCharactersInteractorTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ListCharactersInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupListCharactersInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupListCharactersInteractor() {
        sut = ListCharactersInteractor()
    }
    
    // MARK: - Test doubles
    
    class ListCharactersPresentationLogicSpy: ListCharactersPresentationLogic {
        // MARK: Method call expectations
        
        var presentFetchedCharactersCalled = false
        
        // MARK: Spied methods
        
        func presentFetchedCharacters(response: ListCharacters.FetchCharacters.Response) {
            presentFetchedCharactersCalled = true
        }
    }
    
    class CharactersWorkerSpy: CharactersWorker {
        // MARK: Method call expectations
        
        var fetchCharactersCalled = false
        
        override func fetchCharacters(isFirstPage: Bool, completionHandler: @escaping ([Character]) -> Void) {
            fetchCharactersCalled = true
            completionHandler(Seeds.Characters.characters)
        }
    }
    
    // MARK: - Tests
    
    func testFetchCharactersShouldAskCharacterWorkerToFetchCharactersAndPresenterToFormatResult() {
        //Given
        let listCharactersPresentationLogicSpy = ListCharactersPresentationLogicSpy()
        sut.presenter = listCharactersPresentationLogicSpy
        let charactersWorkerSpy = CharactersWorkerSpy(charactersAPI: CharactersAPI())
        sut.worker = charactersWorkerSpy
        
        //When
        let request = ListCharacters.FetchCharacters.Request(isFirstPage: true)
        sut.fetchCharacters(request: request)
        
        //Then
        XCTAssert(charactersWorkerSpy.fetchCharactersCalled, "FetchCharacters() should ask Worker to fetch characters")
        XCTAssert(listCharactersPresentationLogicSpy.presentFetchedCharactersCalled, "FetchCharacters() should ask presenter to format characters result")
    }
}
