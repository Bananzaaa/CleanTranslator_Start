//
//  Coordinator.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import UIKit

public protocol Coordinator: NSObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    var viewController: UIViewController? { get }
        
    func remove(coordinator: Coordinator)
    func navigationController(_ navigationController: UINavigationController, didDismiss viewController: UIViewController)
    
    func start()
}

public extension Coordinator {
    func remove(coordinator: Coordinator) {
        guard let (index, coordinator) = childCoordinators.enumerated().first(where: { type(of: $0.element) == type(of: coordinator) }) else { return }
        childCoordinators.remove(at: index)
        guard let navigationStackIndex = navigationController.viewControllers.firstIndex(where: { $0 == coordinator.viewController }) else { return }
        navigationController.viewControllers.remove(at: navigationStackIndex)
    }
    
    func navigationController(_ navigationController: UINavigationController, didDismiss viewController: UIViewController) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator.viewController == viewController {
                childCoordinators.remove(at: index)
                return
            }
        }
    }
}
