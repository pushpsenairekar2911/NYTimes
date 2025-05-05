//
//  HomeViewModel.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import SwiftUI
import Combine
import HomeService

open class HomeViewModel: ObservableObject {
    // MARK: - Properties
    @Published var presentationObject: HomePresentationObject = .initialValue
    
    private let viewModelEventSubject: PassthroughSubject<HomeViewModelEvent, Never> = .init()
    
    open var viewModelEvent: AnyPublisher<HomeViewModelEvent, Never> {
        viewModelEventSubject.eraseToAnyPublisher()
    }
    
    private let homeService: HomeServiceInterface
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var articles: [Article]? {
        didSet {
            makePresentationObject()
        }
    }
    
    // MARK: - Initialization
    init(homeService: HomeServiceInterface) {
        self.homeService = homeService
        Task(priority: .high) {
            setupSubscriptions()
        }
        makePresentationObject()
    }
    
    private func setupSubscriptions() {
        homeService.fetchMostPopularArticles()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.performFailure()
                    }
                },
                receiveValue: { [weak self] articles in
                    self?.articles = articles
                }
            )
            .store(in: &cancellables)
    }
    
    func performFailure() {
        self.presentationObject = .init(state: .failed)
    }
    
    @MainActor
    private func didCompleteSubscriptions(subscriptions: Set<AnyCancellable>) {
        self.cancellables = subscriptions
    }
}

// MARK: - Presentation objects
extension HomeViewModel {
    
    private func makePresentationObject() {
        guard let articles = articles, !articles.isEmpty else {
            presentationObject =  HomePresentationObject(state: .loading)
            return
        }
        let articlesPo = articles.map { article in
            return getArticlePo(article: article)
        }
        presentationObject =  HomePresentationObject(state: .loaded(
            articles: articlesPo
        ))
    }
    
    private func getArticlePo(article: Article) -> ArticlePresentationObject {
        return ArticlePresentationObject(
            id: article.id,
            headline: article.title,
            author: article.byline,
            description: article.abstract,
            thumbnail: .remote(url: article.imageURL ?? ""),
            writtenOn: article.publishedDate)
    }
}

// MARK: - Actions
extension HomeViewModel {
    func didTapOnArticle(
        articleId: Int
    ) {
        if let article = articles?.first(where: { $0.id == articleId }) {
            self.viewModelEventSubject.send(.didTapOnArticle(
                article: article)
            )
        }
    }
}
