//
//  RepoCoordinator.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 13.03.2022..
//

import UIKit

final class RepoCoordinator: Coordinator {
    
    // MARK: - PROPERTIES
    
    private var initialViewController: UIViewController?
    
    private let navigationController: UINavigationController
    
    private let user: Users
    
    private let repo: Repo
    
    // MARK: - INIT
    
    init(navigationController: UINavigationController, user: Users, repo: Repo) {
        self.initialViewController = navigationController.viewControllers.last
        self.navigationController = navigationController
        self.user = user
        self.repo = repo
        
        super.init()
    }
    
    // MARK: - OVERRIDES
    
    override func start() {
        let repoViewModel = RepoViewModel(user, repo)
        let repoViewController = RepoViewController(viewModel: repoViewModel)
        navigationController.pushViewController(repoViewController, animated: true)
    }
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // We use === to be sure that viewController & initialViewController reference to same instance
        if viewController === initialViewController { //
            didFinish?(self)
        }
    }
}
