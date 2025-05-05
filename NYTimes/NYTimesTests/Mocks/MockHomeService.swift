//
//  MockHomeService.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 06/05/25.
//

import Combine
import HomeService

final class MockHomeService: HomeServiceInterface {
    var result: Result<[Article], Error> = .success([])

    func fetchMostPopularArticles() -> AnyPublisher<[Article], Error> {
        return result.publisher.eraseToAnyPublisher()
    }
}
