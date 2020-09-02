//
//  ListCharactersInteractor.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ListCharactersBusinessLogic
{
  func doSomething(request: ListCharacters.Something.Request)
}

protocol ListCharactersDataStore
{
  //var name: String { get set }
}

class ListCharactersInteractor: ListCharactersBusinessLogic, ListCharactersDataStore
{
  var presenter: ListCharactersPresentationLogic?
  var worker: ListCharactersWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: ListCharacters.Something.Request)
  {
    worker = ListCharactersWorker()
    worker?.doSomeWork()
    
    let response = ListCharacters.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
