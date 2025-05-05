//
//  HomeDetailsViewModel.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI
import Combine
import HomeService


open class HomeDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var presentationObject: HomeDetailsPresentationObject = .initialValue
    
    private let viewModelEventSubject: PassthroughSubject<HomeDetailsViewModelEvent, Never> = .init()
    
    open var viewModelEvent: AnyPublisher<HomeDetailsViewModelEvent, Never> {
        viewModelEventSubject.eraseToAnyPublisher()
    }

    let article: Article
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Initialization
    init(article: Article) {
        self.article = article
        
        makePresentationObject()
    }
    
    @MainActor
    private func didCompleteSubscriptions(subscriptions: Set<AnyCancellable>) {
        self.cancellables = subscriptions
    }
}

// MARK: - Presentation objects
extension HomeDetailsViewModel {
    
    private func makePresentationObject() {
        let articlePo = ArticleDetailPresentationObject(
            id: article.id,
            headline: article.title,
            author: article.byline,
            description: article.abstract,
            thumbnail: .remote(url: article.imageURL ?? ""),
            writtenOn: article.publishedDate,
            source: article.source,
            navigationLink: article.url,
            section: article.section,
            subSection: article.subsection)

        presentationObject =  HomeDetailsPresentationObject(state: .loaded(article: articlePo))
    }
    
    func didTapOnNavigationBack() {
        self.viewModelEventSubject.send(.didTapOnNavigationBack)
        self.viewModelEventSubject.send(completion: .finished)
    }
}
