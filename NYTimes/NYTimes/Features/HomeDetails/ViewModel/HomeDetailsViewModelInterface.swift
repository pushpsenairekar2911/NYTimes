//
//  HomeDetailsViewModelInterface.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI
import Combine
import Foundation
import NYKit

// MARK: - ViewModel Event
/// View model publishes these events to the subcribers (typically coordinators) to communicate any action
public enum HomeDetailsViewModelEvent {
    case didTapOnNavigationBack
}

typealias ArticleDetailPresentationObject = HomeDetailsPresentationObject.ArticlePresentationObject

// MARK: - HomePresentationObject
public struct HomeDetailsPresentationObject: Sendable {
    
    static let initialValue: HomeDetailsPresentationObject = .init(state: .loading)

    enum State: Sendable {
        case loading
        case loaded(article: ArticlePresentationObject)
        case failed
    }
    
    struct ArticlePresentationObject: Identifiable, Sendable {
        let id : Int
        let headline: String?
        let author: String?
        let description: String?
        let thumbnail: NYImageSource?
        let writtenOn: String?
        let source: String?
        let navigationLink: String?
        let section: String?
        let subSection: String?
    }
    
    let state: State
}


