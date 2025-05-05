//
//  ArticleRepositoryTests.swift
//  HomeServiceTests
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import XCTest
@testable import HomeService
import Combine


final class HomeServiceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    func testFetchArticlesSuccess() {
        let mockService = MockHomeServiceInterface()
        mockService.articlesToReturn = [
            Article(id: 123, uri: "uri", url: "url", assetID: 123, source: "test", publishedDate: "01/01/2025", updated: "02/01/2025", section: "Test", subsection: "", nytdsection: "", adxKeywords: "", byline: "", type: "", title: "Test", abstract: "", desFacet: [], orgFacet: [], perFacet: [], geoFacet: [], media: nil, etaID: 1)
        ]
        
        let expectation = XCTestExpectation(description: "Fetch articles")
        
        mockService.fetchMostPopularArticles()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success")
                }
            }, receiveValue: { articles in
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles.first?.title, "Test")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchArticlesFailure() {
        let mockService = MockHomeServiceInterface()
        mockService.shouldFail = true
        
        let expectation = XCTestExpectation(description: "Handle failure")
        
        mockService.fetchMostPopularArticles()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is URLError)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no articles")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}

