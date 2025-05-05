//
//  HomeViewModelInterface.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import SwiftUI
import Combine
import Foundation
import NYKit
import HomeService

// MARK: - ViewModel Event
/// View model publishes these events to the subcribers (typically coordinators) to communicate any action
public enum HomeViewModelEvent {
    case didTapOnArticle(article: Article)
}

typealias ArticlePresentationObject = HomePresentationObject.ArticlePresentationObject

// MARK: - HomePresentationObject
public struct HomePresentationObject: Sendable {
    
    static let initialValue: HomePresentationObject = .init(state: .loading)

    enum State: Sendable {
        case loading
        case loaded(articles: [ArticlePresentationObject])
        case failed
    }
    
    struct ArticlePresentationObject: Identifiable, Sendable {
        let id : Int
        let headline: String?
        let author: String?
        let description: String?
        let thumbnail: NYImageSource?
        let writtenOn: String?
    }
    
    let state: State
}


