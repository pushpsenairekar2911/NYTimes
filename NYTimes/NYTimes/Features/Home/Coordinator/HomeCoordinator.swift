//
//  HomeCoordinator.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Combine
import SwiftUI
import HomeService

// MARK: - Coordinator Event
enum HomeCoordinatorEvent {
    case navigateToDetails(article: String)
}

class HomeCoordinator: BaseCoordinator, UIAdaptivePresentationControllerDelegate {
    
    // Publisher
    private let coordinatorEventSubject: PassthroughSubject<HomeCoordinatorEvent, Never> = .init()
    
    var coordinatorEventPublisher: AnyPublisher<HomeCoordinatorEvent, Never> {
        return coordinatorEventSubject.eraseToAnyPublisher()
    }
    
    private var articleDetailsViewModelEventSubscription: Cancellable?
    
    let homeService: HomeServiceInterface
    
    init(homeService: HomeServiceInterface) {
        self.homeService = homeService
    }
    
    private lazy var rootViewController: UIHostingController<HomeView> = {
        let viewModel = HomeViewModel(
            homeService: homeService
        )
        let homeView = HomeView(viewModel: viewModel)
        let homeViewController = UIHostingController(rootView: homeView)
        viewModel.viewModelEvent
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                self?.processEvent(event: event)
            }
            .store(in: &cancellables)
        return homeViewController
    }()
    
    // MARK: Overrides
    override func start() -> UIViewController {
        return UINavigationController(rootViewController: rootViewController)
    }
    
    private func processEvent(
        event: HomeViewModelEvent
    ) {
        switch event {
        case .didTapOnArticle(let article):
            navigateToHomeDetails(with: article)
        }
    }
}

// MARK: - Navigate to home details
extension HomeCoordinator {
    private func navigateToHomeDetails(
        with article: Article
    ) {
        let viewModel = HomeDetailsViewModel(
            article: article
        )
        let homeDetailsView = HomeDetails(
            viewModel: viewModel
        )
        articleDetailsViewModelEventSubscription = viewModel.viewModelEvent
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.articleDetailsViewModelEventSubscription = nil
            }, receiveValue: { [weak self] event in
                self?.processEvent(event: event)
            })
        
        let homeDetailsViewController = UIHostingController(rootView: homeDetailsView)
        rootViewController.navigationController?.navigationBar.isHidden = true
        rootViewController.navigationController?.pushViewController(
            homeDetailsViewController, animated: true
        )
    }
    
    private func processEvent(event: HomeDetailsViewModelEvent) {
        switch event {
        case .didTapOnNavigationBack:
            rootViewController.navigationController?.navigationBar.isHidden = false
            rootViewController.navigationController?.popViewController(animated: true)
            break
        }
    }
}
