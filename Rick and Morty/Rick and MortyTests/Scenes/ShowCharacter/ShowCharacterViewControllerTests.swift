//
//  ShowCharacterViewControllerTests.swift
//  Rick and MortyTests
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

@testable import Rick_and_Morty
import XCTest

class ShowCharacterViewControllerTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ShowCharacterViewController!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupShowCharacterViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupShowCharacterViewController() {
        sut = ShowCharacterViewController()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    
    class ShowCharacterBusinessLogicSpy: ShowCharacterBusinessLogic {
        
        var character: Character!
        
        // MARK: Method call expectations
        
        var getCharacterCalled = false
        var toggleFavoriteCharacterCalled = false
        
        // MARK: Spied methods
        
        func getCharacter(request: ShowCharacter.GetCharacter.Request) {
            getCharacterCalled = true
        }
        
        func toggleFavoriteCharacter(request: ShowCharacter.ToggleFavoriteCharacter.Request) {
            toggleFavoriteCharacterCalled = true
        }
    }
    
    class TableViewSpy: ShowCharacterView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldShowCharacterWhenViewIsLoaded() {
        //Given
        let showCharacterBusinessLogicSpy = ShowCharacterBusinessLogicSpy()
        sut.interactor = showCharacterBusinessLogicSpy
        loadView()
        
        //When
        sut.viewDidAppear(true)
        
        //Then
        XCTAssert(showCharacterBusinessLogicSpy.getCharacterCalled, "Should show character when the view is loaded")
    }
    
    func testShouldAskInteractorToToggleFavorite() {
        //Given
        let showCharacterBusinessLogicSpy = ShowCharacterBusinessLogicSpy()
        sut.interactor = showCharacterBusinessLogicSpy
        
        //When
        sut.toggleFavorite()
        
        //Then
        XCTAssert(showCharacterBusinessLogicSpy.toggleFavoriteCharacterCalled, "Should ask interactor when toggle favorite")
    }
    
    func testShouldDisplayFetchedCharacter() {
        //Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        //When
        let displayedCharacter = ShowCharacter.GetCharacter.ViewModel.DisplayedCharacter(id: 1, name: "AAA", status: "Alive", species: "Human", type: "", gender: "Male", origin: "Earth", location: "Earth", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", favorite: false)
        let viewModel = ShowCharacter.GetCharacter.ViewModel(displayedCharacter: displayedCharacter)
        sut.displayCharacter(viewModel: viewModel)
        
        //Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched character should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        //Given
        let tableView = sut.tableView
        
        //When
        let numberOfSections = sut.numberOfSections(in: tableView!)
        
        //Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInAnySectionShouldAlwaysBeFour() {
        //Given
        let tableView = sut.tableView
        let testDisplayedCharacter = ShowCharacter.GetCharacter.ViewModel.DisplayedCharacter(id: 1, name: "AAA", status: "Alive", species: "Human", type: "", gender: "Male", origin: "Earth", location: "Earth", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", favorite: false)
        sut.displayedCharacter = testDisplayedCharacter
        
        //When
        let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(numberOfRows, 4, "The number of table view rows should always be 4")
    }
    
    func testShouldConfigureTableViewCellToDisplayCharacter() {
        //Given
        let tableView = sut.tableView
        let image = UIImageView()
        image.downloaded(from: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", contentMode: .scaleAspectFill)
        
        //When
        let displayedCharacter = ShowCharacter.GetCharacter.ViewModel.DisplayedCharacter(id: 1, name: "AAA", status: "Alive", species: "Human", type: "", gender: "Male", origin: "Earth", location: "Earth", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", favorite: false)
        sut.displayedCharacter = displayedCharacter
        let headerView = sut.tableView(tableView!, viewForHeaderInSection: 0) as! ShowCharacterHeaderView
        let genderCell = sut.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0)) as! ShowCharacterViewCell
        let originCell = sut.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0)) as! ShowCharacterViewCell
        let typeCell = sut.tableView(tableView!, cellForRowAt: IndexPath(row: 2, section: 0)) as! ShowCharacterViewCell
        let locationCell = sut.tableView(tableView!, cellForRowAt: IndexPath(row: 3, section: 0)) as! ShowCharacterViewCell
        
        //Then
        XCTAssertEqual(headerView.name.text, "AAA", "Displaying a character should update the character name label")
        XCTAssertEqual(headerView.status.text, "Alive", "Displaying a character should update the character status label")
        XCTAssertEqual(headerView.species.text, "Human", "Displaying a character should update the character secies label")
        XCTAssertEqual(headerView.avatar.image, image.image, "Displaying a character should update the character avatar image")
        XCTAssertEqual(genderCell.subtitle.text, "Male", "Displaying a character should update the character gender label")
        XCTAssertEqual(originCell.subtitle.text, "Earth", "Displaying a character should update the character origin label")
        XCTAssertEqual(typeCell.subtitle.text, "Unknown", "Displaying a character should update the character type label")
        XCTAssertEqual(locationCell.subtitle.text, "Earth", "Displaying a character should update the character location label")
    }
}
