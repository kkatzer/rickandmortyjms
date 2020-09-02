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
        let windowScene:UIWindowScene = scene as! UIWindowScene;
        self.window = UIWindow(windowScene: windowScene)
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.tintColor = UIColor(named: "Primary")
        
        let listCharactersNavigation = UINavigationController(nibName: nil, bundle: nil)
        listCharactersNavigation.viewControllers = [ListCharactersViewController()]
        listCharactersNavigation.navigationBar.prefersLargeTitles = true
        
//        let locationNavigation = UINavigationController(nibName: nil, bundle: nil)
//        locationNavigation.viewControllers = [LocationListViewController()]
//
//        let episodeNavigation = UINavigationController(nibName: nil, bundle: nil)
//        episodeNavigation.viewControllers = [EpisodeListViewController()]

        tabBarVC.viewControllers = [listCharactersNavigation]
        window?.rootViewController = listCharactersNavigation
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }


}

