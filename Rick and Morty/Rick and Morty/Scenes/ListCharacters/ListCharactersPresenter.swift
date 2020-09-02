//
//  ListCharactersPresenter.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ListCharactersPresentationLogic
{
  func presentSomething(response: ListCharacters.Something.Response)
}

class ListCharactersPresenter: ListCharactersPresentationLogic
{
  weak var viewController: ListCharactersDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ListCharacters.Something.Response)
  {
    let viewModel = ListCharacters.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
