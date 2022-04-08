//
//  SceneDelegate.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 01.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        guard let view = window?.rootViewController?.view as? View else { return }
        view.setBirdGravityDirection(direction: .Down)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        
    }


}

