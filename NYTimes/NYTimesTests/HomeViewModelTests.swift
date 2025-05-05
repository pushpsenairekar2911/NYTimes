//
//  HomeViewModelTests.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 06/05/25.
//

import XCTest
import Combine
import HomeService
@testable import NYTimes

final class HomeViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testSuccessfulArticleFetchUpdatesPresentationObject() {
        // Arrange
        let article = Article(
            id: 1,
            uri: "uri",
            url: "url",
            assetID: 1,
            source: "Test",
            publishedDate: "01/01/2025",
            updated: "01/01/2025",
            section: "Tech",
            subsection: "AI",
            nytdsection: "NYT",
            adxKeywords: "",
            byline: "Test Author",
            type: "",
            title: "Test Title",
            abstract: "Test Abstract",
            desFacet: [],
            orgFacet: [],
            perFacet: [],
            geoFacet: [],
            media: [],
            etaID: 1
        )

        let mockService = MockHomeService()
        mockService.result = .success([article])

        let viewModel = HomeViewModel(homeService: mockService)

        // Act
        let expectation = XCTestExpectation(description: "Wait for async presentation update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if case let .loaded(articles) = viewModel.presentationObject.state {
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles[0].headline, "Test Title")
                expectation.fulfill()
            } else {
                XCTFail("Expected loaded state")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFailureUpdatesPresentationToFailed() {
        // Arrange
        let mockService = MockHomeService()
        mockService.result = .failure(URLError(.badServerResponse))

        let viewModel = HomeViewModel(homeService: mockService)

        // Act
        let expectation = XCTestExpectation(description: "Wait for failed presentation state")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if case .failed = viewModel.presentationObject.state {
                expectation.fulfill()
            } else {
                XCTFail("Expected failed state")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testDidTapOnArticlePublishesCorrectEvent() {
        // Arrange
        let article = Article(
            id: 42,
            uri: "uri",
            url: "url",
            assetID: 42,
            source: "Test",
            publishedDate: "01/01/2025",
            updated: "01/01/2025",
            section: "Tech",
            subsection: "AI",
            nytdsection: "NYT",
            adxKeywords: "",
            byline: "Test Author",
            type: "",
            title: "Test Title",
            abstract: "Test Abstract",
            desFacet: [],
            orgFacet: [],
            perFacet: [],
            geoFacet: [],
            media: [],
            etaID: 42
        )

        let mockService = MockHomeService()
        mockService.result = .success([article])

        let viewModel = HomeViewModel(homeService: mockService)

        // Act
        let expectation = XCTestExpectation(description: "Expect article tap event")
        viewModel.viewModelEvent
            .sink { event in
                if case let .didTapOnArticle(tappedArticle) = event {
                    XCTAssertEqual(tappedArticle.id, 42)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            viewModel.didTapOnArticle(articleId: 42)
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
