//
//  AppCoordinator.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 13.03.2022..
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - PROPERTIES
    
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.Colors.navigationBarColor
        
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        return navigationController
    }
    
    // MARK: - INIT
    
    override init() {
        super.init()
        
        let usersCoordinator = UsersCoordinator(navigationController: navigationController)

        childCoordinators.append(usersCoordinator)
    }
    
    override func start() {
        childCoordinators.forEach { childCoordinator in
            childCoordinator.start()
        }
    }
}
