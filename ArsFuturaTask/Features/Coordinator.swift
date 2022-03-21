//
//  Coordinator.swift
//  ArsFuturaTask
//
//  Created by Hrvoje Vuković on 13.03.2022..
//

import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate {
    
    // MARK: - PROPERTIES
    
    var didFinish: ((Coordinator) -> ())?
    var childCoordinators: [Coordinator] = []
    
    // MARK: - METHODS
    
    func start() {}
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
    
    // Start new coordinator and add new coordinator to child coordinator
    func pushCoordinator(_ coordinator: Coordinator) {
        // Install handler
        coordinator.didFinish = { [weak self] (coordinator) in
            self?.popCoordinator(coordinator)
        }
        
        coordinator.start()

        childCoordinators.append(coordinator)
    }
    
    func popCoordinator(_ coordinator: Coordinator) {
        // Remove coordinator from child coordinators
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
