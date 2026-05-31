//
//  SceneDelegate.swift
//  module4lesson3
//
//  Created by Andrew on 29.05.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let vc = NewsViewController.create()
        let navigationVC = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

