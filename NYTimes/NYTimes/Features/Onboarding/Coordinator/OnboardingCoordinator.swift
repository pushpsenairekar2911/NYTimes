
//
//  OnboardingCoordinator.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 04/05/25.
//


import Combine
import Foundation
import os
import SwiftUI
import UIKit
import SafariServices
import HomeService

// MARK: - Coordinator Event
enum OnboardingCoordinatorEvent {
    /// Events that HomeCoordinator passes to its parent coordinator
    case launchHomeScreen
}

class OnboardingCoordinator: BaseNavigableCoordinator {

    // Publisher
    private let coordinatorEventSubject: PassthroughSubject<OnboardingCoordinatorEvent, Never> = .init()
    
    var coordinatorEventPublisher: AnyPublisher<OnboardingCoordinatorEvent, Never> {
        return coordinatorEventSubject.eraseToAnyPublisher()
    }
    
    let homeService : HomeServiceInterface
    
    let viewModel : OnboardingViewModel
    
    private var onboardingViewModelEventSubscription: AnyCancellable?
    
    private var homeCoordinator: HomeCoordinator?
    
    private lazy var rootView: some View = {
        let homeView = OnboardingView(
            viewModel: self.viewModel
        )
        return homeView
    }()

    init(viewModel: OnboardingViewModel = .init(),
         homeService: HomeServiceInterface) {
        self.viewModel = viewModel
        self.homeService = homeService
    }
    
    // MARK: Overrides
    func start() -> some View {
        onboardingViewModelEventSubscription = viewModel.viewModelEvent
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.onboardingViewModelEventSubscription = nil
            }, receiveValue: { [weak self] event in
                self?.processEvent(event: event)
            })
        return rootView
    }
    
    private func processEvent(event: OnboardingViewModelEvent) {
        switch event {
        case .didTapOnGetStarted:
            navigateToHomeScreen()
        }
    }
}

extension OnboardingCoordinator {
    
    private func navigateToHomeScreen() {
        let homeCoordinator = HomeCoordinator(homeService: homeService)
        self.homeCoordinator = homeCoordinator
        
        let finishHandler: CoordinatorDidFinishHandler = { [weak self] coordinator in
           // self?.dismiss
            self?.removeChildCoordinator(coordinator)
            self?.homeCoordinator = nil
        }
        
        let homeCoordinatorVC = addChildCoordinator(
            homeCoordinator,
            finishHandler: finishHandler
        )
        
        homeCoordinatorVC.modalPresentationStyle = .fullScreen
        
        if let topVC = UIApplication.getTopViewController() {
            topVC.present(homeCoordinatorVC, animated: true)
        }
    }
}


extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
