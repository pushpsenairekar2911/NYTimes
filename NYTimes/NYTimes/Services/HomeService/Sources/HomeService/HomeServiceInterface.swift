//
//  HomeServiceInterface.swift
//  HomeService
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import Combine

public protocol HomeServiceInterface {
    
    func fetchMostPopularArticles() -> AnyPublisher<[Article], Error>
}
