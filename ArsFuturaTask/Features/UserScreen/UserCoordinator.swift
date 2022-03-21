//
//  UserCoordinator.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 13.03.2022..
//

import UIKit

final class UserCoordinator: Coordinator {
    
    // MARK: - PROPERTIES

    private var initialViewController: UIViewController?
    
    private let navigationController: UINavigationController
    
    private let repository: Repository
    
    private let user: Users
    
    // MARK: - INIT
    
    init(navigationController: UINavigationController, repository: Repository, user: Users) {
        self.initialViewController = navigationController.viewControllers.last
        self.navigationController = navigationController
        self.repository = repository
        self.user = user
        
        super.init()
    }
    
    // MARK: - OVERRIDES
    
    override func start() {
        let userViewModel = UserViewModel(repository, user)
        
        userViewModel.didSelectRepo = { [weak self] (user, repo) in
            self?.showRepo(user, repo)
        }
        
        let userViewController = UserViewController(viewModel: userViewModel)
        
        navigationController.pushViewController(userViewController, animated: true)
    }
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // We use === to be sure that viewController & initialViewController reference to same instance
        if viewController === initialViewController { //
            didFinish?(self)
        }
        
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
        }
    }
    
    // MARK: - HELPER METHODS
    
    private func showRepo(_ user: Users, _ repo: Repo) {
        let repoCoordinator = RepoCoordinator(navigationController: navigationController, user: user, repo: repo)
        pushCoordinator(repoCoordinator)
    }
}
