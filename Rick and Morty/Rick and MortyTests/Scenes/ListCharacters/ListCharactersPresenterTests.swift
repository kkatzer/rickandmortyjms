//
//  ListCharactersPresenterTests.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class ListCharactersPresenterTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ListCharactersPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupListCharactersPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupListCharactersPresenter() {
        sut = ListCharactersPresenter()
    }
    
    // MARK: - Test doubles
    
    class ListCharactersDisplayLogicSpy: ListCharactersDisplayLogic {
        // MARK: Method call expectations
        
        var displayFetchedCharactersCalled = false
        
        // MARK: Argument exectations
        
        var viewModel: ListCharacters.FetchCharacters.ViewModel!
        
        // MARK: Spied methods
        
        func displayFetchedCharacters(viewModel: ListCharacters.FetchCharacters.ViewModel) {
            displayFetchedCharactersCalled = true
            self.viewModel = viewModel
        }
    }
    
    // MARK: - Tests
    
    func testPresentFetchedCharactersShouldFormatFetchedCharactersForDisplay() {
        //Given
        let listCharactersDisplayLogicSpy = ListCharactersDisplayLogicSpy()
        sut.viewController = listCharactersDisplayLogicSpy
        
        //When
        let characters = [Seeds.Characters.characters.first!]
        let response = ListCharacters.FetchCharacters.Response(characters: characters)
        sut.presentFetchedCharacters(response: response)
        
        //Then
        let displayedCharacters = listCharactersDisplayLogicSpy.viewModel.displayedCharacters
        for displayedCharacter in displayedCharacters {
            XCTAssertEqual(displayedCharacter.id, 1, "Presenting fetched characters should properly format character Id")
            XCTAssertEqual(displayedCharacter.name, "Rick Sanchez", "Presenting fetched characters should properly format character name")
            XCTAssertEqual(displayedCharacter.status, "Alive", "Presenting fetched characters should properly format character status")
            XCTAssertEqual(displayedCharacter.image, "https://rickandmortyapi.com/api/character/avatar/1.jpeg", "Presenting fetched characters should properly format character image")
            XCTAssertEqual(displayedCharacter.favorite, false, "Presenting fetched characters should properly format character favorite status")
        }
    }
    
    func testPresentFetchedCharactersShouldAskViewControllerToDisplayFetchedCharacters() {
        //Given
        let listCharactersDisplayLogicSpy = ListCharactersDisplayLogicSpy()
        sut.viewController = listCharactersDisplayLogicSpy
        
        //When
        let characters = Seeds.Characters.characters
        let response = ListCharacters.FetchCharacters.Response(characters: characters)
        sut.presentFetchedCharacters(response: response)
        
        //Then
        XCTAssert(listCharactersDisplayLogicSpy.displayFetchedCharactersCalled, "Presenting fetched characters should ask view controller to display them")
    }
}
