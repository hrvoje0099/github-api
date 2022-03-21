//
//  UsersCoordinator.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 13.03.2022..
//

import Foundation
import UIKit

final class UsersCoordinator: Coordinator {
    
    //  MARK: - PROPERTIES
    
    private let navigationController: UINavigationController
    
    // MARK: - INIT
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: - OVERRIDES
    
    override func start() {
        navigationController.delegate = self
        
        let usersViewModel = UsersViewModel(repository: Repository())
        
        usersViewModel.didSelectUser = { [weak self] (repository, user) in
            self?.showUser(repository, user)
        }
        
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        
        navigationController.pushViewController(usersViewController, animated: true)
    }
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
        }
    }
    
    // MARK: - HELPER FUNCTIONS
    
    private func showUser(_ repository: Repository, _ user: Users) {
        let userCoordinator = UserCoordinator(navigationController: navigationController, repository: repository, user: user)
        pushCoordinator(userCoordinator)
    }
}
