//
//  ShowCharacterPresenterTests.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class ShowCharacterPresenterTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ShowCharacterPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupShowCharacterPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupShowCharacterPresenter() {
        sut = ShowCharacterPresenter()
    }
    
    // MARK: - Test doubles
    
    class ShowCharacterDisplayLogicSpy: ShowCharacterDisplayLogic {
        
        // MARK: Method call expectaions
        
        var displayFetchedCharacterCalled = false
        var displayFetchedFavoriteCalled = false
        
        // MARK: Argument expectations
        
        var characterViewModel: ShowCharacter.GetCharacter.ViewModel!
        var favoriteViewModel: ShowCharacter.ToggleFavoriteCharacter.ViewModel!
        
        // MARK: Spied methods
        
        func displayCharacter(viewModel: ShowCharacter.GetCharacter.ViewModel) {
            displayFetchedCharacterCalled = true
            self.characterViewModel = viewModel
        }
        
        func displayFavorite(viewModel: ShowCharacter.ToggleFavoriteCharacter.ViewModel) {
            displayFetchedFavoriteCalled = true
            self.favoriteViewModel = viewModel
        }
    }
    
    // MARK: - Tests
    
    func testPresentFetchedCharacterShouldFormatFetchedCharacterForDisplay() {
        //Given
        let showCharacterDisplayLogicSpy = ShowCharacterDisplayLogicSpy()
        sut.viewController = showCharacterDisplayLogicSpy
        
        //When
        let character = Seeds.Characters.characters.first!
        let response = ShowCharacter.GetCharacter.Response(character: character)
        sut.presentFetchedCharacter(response: response)
        
        //Then
        let displayedCharacter = showCharacterDisplayLogicSpy.characterViewModel.displayedCharacter
        XCTAssertEqual(displayedCharacter.id, 1, "Presenting fetched character should properly format character Id")
        XCTAssertEqual(displayedCharacter.name, "Rick Sanchez", "Presenting fetched character should properly format character name")
        XCTAssertEqual(displayedCharacter.status, "Alive", "Presenting fetched character should properly format character status")
        XCTAssertEqual(displayedCharacter.image, "https://rickandmortyapi.com/api/character/avatar/1.jpeg", "Presenting fetched character should properly format character image")
        XCTAssertEqual(displayedCharacter.favorite, false, "Presenting fetched character should properly format character favorite status")
    }
    
    func testPresentFavoriteShouldFormatFavoriteForDisplay() {
        //Given
        let showCharacterDisplayLogicSpy = ShowCharacterDisplayLogicSpy()
        sut.viewController = showCharacterDisplayLogicSpy
        
        //When
        let response = ShowCharacter.ToggleFavoriteCharacter.Response(favorite: true)
        sut.presentFavorite(response: response)
        
        //Then
        let favorite = showCharacterDisplayLogicSpy.favoriteViewModel.favorite
        XCTAssertEqual(favorite, true, "Presenting fetched favorite should properly format favorite")
    }
    
    func testPresentFetchedCharactersShouldAskViewControllerToDisplayFetchedCharacters() {
        //Given
        let showCharacterDisplayLogicSpy = ShowCharacterDisplayLogicSpy()
        sut.viewController = showCharacterDisplayLogicSpy

        //When
        let character = Seeds.Characters.characters.first!
        let response = ShowCharacter.GetCharacter.Response(character: character)
        sut.presentFetchedCharacter(response: response)

        //Then
        XCTAssert(showCharacterDisplayLogicSpy.displayFetchedCharacterCalled, "Presenting fetched character should ask view controller to display them")
    }
    
    func testPresentFavoriteShouldAskViewControllerToDisplayFavorite() {
        //Given
        let showCharacterDisplayLogicSpy = ShowCharacterDisplayLogicSpy()
        sut.viewController = showCharacterDisplayLogicSpy

        //When
        let favorite = true
        let response = ShowCharacter.ToggleFavoriteCharacter.Response(favorite: favorite)
        sut.presentFavorite(response: response)

        //Then
        XCTAssert(showCharacterDisplayLogicSpy.displayFetchedFavoriteCalled, "Presenting fetched favorite should ask view controller to display them")
    }
}
