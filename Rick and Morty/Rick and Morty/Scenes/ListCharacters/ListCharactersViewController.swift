//
//  ListCharactersViewController.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

protocol ListCharactersDisplayLogic: class
{
  func displaySomething(viewModel: ListCharacters.Something.ViewModel)
}

class ListCharactersViewController: UIViewController, ListCharactersDisplayLogic
{
  var interactor: ListCharactersBusinessLogic?
  var router: (NSObjectProtocol & ListCharactersRoutingLogic & ListCharactersDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let view = ListCharactersView()
    let interactor = ListCharactersInteractor()
    let presenter = ListCharactersPresenter()
    let router = ListCharactersRouter()
    viewController.view = view
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = ListCharacters.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: ListCharacters.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
