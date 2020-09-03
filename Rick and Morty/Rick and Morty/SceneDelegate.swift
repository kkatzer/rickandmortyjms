//
//  SceneDelegate.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let listCharactersNavigation = UINavigationController(nibName: nil, bundle: nil)
        listCharactersNavigation.viewControllers = [ListCharactersViewController()]
        listCharactersNavigation.navigationBar.prefersLargeTitles = true
        
        window?.rootViewController = listCharactersNavigation
        window?.makeKeyAndVisible()
    }


}

