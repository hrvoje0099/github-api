//
//  SceneDelegate.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 17.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.Colors.navigationBarColor
        
        let usersViewModel = UsersViewModel()
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        let navigationController = UINavigationController(rootViewController: usersViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
