//
//  ListCharactersViewControllerTest.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class ListCharactersViewControllerTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ListCharactersViewController!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListCharactersViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupListCharactersViewController() {
        sut = ListCharactersViewController()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    
    class ListCharactersBusinessLogicSpy: ListCharactersBusinessLogic {
        var characters: [Character]?
        
        // MARK: Method call expectations
        
        var fetchCharactersCalled = false
        
        // MARK: Spied methods
        
        func fetchCharacters(request: ListCharacters.FetchCharacters.Request) {
            fetchCharactersCalled = true
        }
    }
    
    class CollectionViewSpy: UICollectionView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldFetchCharactersWhenViewDidAppear() {
        //Given
        let listCharactersBusinessLogicSpy = ListCharactersBusinessLogicSpy()
        sut.interactor = listCharactersBusinessLogicSpy
        loadView()
        
        //When
        sut.viewDidAppear(true)
        
        //Then
        XCTAssert(listCharactersBusinessLogicSpy.fetchCharactersCalled, "Should fetch characters right after the view appears")
    }
    
    func testShouldDisplayFetchedCharacters() {
        //Given
        let collectionViewSpy = CollectionViewSpy(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        sut.collectionView = collectionViewSpy
        
        //When
        let displayedCharacters = [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter(id: 1, name: "ABC", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", favorite: false)]
        let viewModel = ListCharacters.FetchCharacters.ViewModel(displayedCharacters: displayedCharacters)
        sut.displayFetchedCharacters(viewModel: viewModel)
        
        //Then
        XCTAssert(collectionViewSpy.reloadDataCalled, "Displaying fetched characters should reload the collection view")
    }
    
    func testNumberOfSectionsInCollectionViewShouldAlwaysBeOne() {
        //Given
        let collectionView = sut.collectionView
        
        //When
        let numberOfSections = sut.numberOfSections(in: collectionView!)
        
        //Then
        XCTAssertEqual(numberOfSections, 1, "The number of collection view sections should always be 1")
    }
    
    func testNumberOfItemsInAnySectionShouldBeEqualNumberOfCharactersToDisplay() {
        //Given
        let collectionView = sut.collectionView
        let testDisplayedCharacters = [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter(id: 1, name: "ABC", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", favorite: false)]
        sut.displayedCharacters = testDisplayedCharacters
        
        //When
        let numberOfItems = sut.collectionView(collectionView!, numberOfItemsInSection: 0)
        
        //Then
        XCTAssertEqual(numberOfItems, testDisplayedCharacters.count, "The number of collection view items should equal the number of characters to display")
    }
    
    func testShouldConfigurateCollectionViewCellToDisplayCharacter() {
        //Given
        let collectionView = sut.collectionView
        let testDisplayedCharacters = [ListCharacters.FetchCharacters.ViewModel.DisplayedCharacter(id: 1, name: "ABC", status: "Alive", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", favorite: false)]
        let image = UIImageView()
        image.downloaded(from: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", contentMode: .scaleAspectFill)
        sut.displayedCharacters = testDisplayedCharacters
        
        //When
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = sut.collectionView(collectionView!, cellForItemAt: indexPath) as! ListCharactersViewCell
        
        //Then
        XCTAssertEqual(cell.title.text, "ABC", "A properly configured collection view cell should display the character name")
        XCTAssertEqual(cell.status.text, "Alive", "A properly configured collection view cell should display the character status")
        XCTAssertEqual(cell.image.image, image.image, "A properly configured collection view cell should display the character image")
        XCTAssertEqual(cell.favoriteIcon.isHidden, true, "A properly configured collection view cell should correctly display the character favorite icon")
    }
}
