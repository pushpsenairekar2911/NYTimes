//
//  BaseCoordinators.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Combine
import Foundation
import UIKit

public typealias CoordinatorDidFinishHandler = ((CoordinatorInterface) -> Void)

open class BaseCoordinator: NSObject, CoordinatorInterface {
    // MARK: - Properties
    public let identifier = UUID()
    public var childCoordinators: [UUID: CoordinatorInterface] = [:]
    public var didFinish: CoordinatorDidFinishHandler?
    public var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    open func start() -> UIViewController {
        fatalError("A subclass must override this method to return the view controller it manages")
    }
    
    open func finish() {
        // Subclasses must override this to handle their state before finishing.
    }
    
    public func addChildCoordinator(
        _ childCoordinator: CoordinatorInterface,
        finishHandler: CoordinatorDidFinishHandler? = nil
    ) -> UIViewController {
        if let finishHandler = finishHandler {
            childCoordinator.didFinish = finishHandler
        } else {
            childCoordinator.didFinish = { [weak self] coordinator in
                self?.removeChildCoordinator(coordinator)
            }
        }
        childCoordinators[childCoordinator.identifier] = childCoordinator
        return childCoordinator.start()
    }

    public func removeChildCoordinator(_ childCoordinator: CoordinatorInterface) {
        childCoordinators[childCoordinator.identifier] = nil
    }
}

/// A NavigableCoordinator is an abstract coordinator which works with an externally provided navigation controller.
/// The child view controllers handled by this coordinator  or any of its subclass are pushed to the provided navigationController
/// subclass NavigableCoordinator If your coordinator needs to push its view controller to its parent's navigation stack
open class NavigableCoordinator: BaseCoordinator {
    public let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        if let swipeableNavigationController = navigationController as? SwipeableNavigationController {
            swipeableNavigationController.parentCoordinator = self
        }
    }
    
    open var disableInteractivePopGesture: Bool = false
    
    open func didChangeTopViewController(
        from sourceViewController: UIViewController,
        to destinationViewController: UIViewController
    ) {
        /// Override in subclass to complete clean up when navigation stack's top view changes from source to destination
    }
}

/// A special purpose NavigableCoordinator which defines its own UINavigationController to push child view controllers.
/// Subclass BaseNavigableCoordinator if your coordinator is the root of a navigation controller scene.
open class BaseNavigableCoordinator: NavigableCoordinator {
    
    public init() {
        let navigationController = SwipeableNavigationController()
        super.init(navigationController: navigationController)
        navigationController.parentCoordinator = self
    }
}

open class SwipeableNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    weak var parentCoordinator: NavigableCoordinator?
    var swipeTransitionFromViewController: UIViewController?
    var swipeTransitionToViewController: UIViewController?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        interactivePopGestureRecognizer?.isEnabled = false
    }
    
    open override func popViewController(animated: Bool) -> UIViewController? {
        let poppedViewController = super.popViewController(animated: animated)
        return poppedViewController
    }

    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        interactivePopGestureRecognizer?.isEnabled = true
        
        if let fromVC = swipeTransitionFromViewController,
            let toVC = swipeTransitionToViewController,
            toVC == viewController {
            parentCoordinator?.didChangeTopViewController(from: fromVC, to: toVC)
            
            swipeTransitionToViewController = nil
            swipeTransitionFromViewController = nil
        }
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { [weak self] (context) in
                guard !context.isCancelled else { return }
                guard let self = self else { return }
                self.swipeTransitionFromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)
                self.swipeTransitionToViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)
            }
        }
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
    
    open override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }

        return .default
    }
}
