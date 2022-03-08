//
//  SceneDelegate.swift
//  CleanTranslator_Start
//
//  Created by Stanislav Anatskii on 06.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let startViewController = UINavigationController(rootViewController: TranslationScreenViewController())
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }

}

