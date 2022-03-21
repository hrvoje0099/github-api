//
//  SceneDelegate.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let appCoordinator = AppCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
    }
}
