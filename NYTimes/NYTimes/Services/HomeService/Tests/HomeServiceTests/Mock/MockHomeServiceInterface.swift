//
//  MockHomeServiceInterface.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/10/24.
//

import Foundation
import HomeService
import Combine

class MockHomeServiceInterface: HomeServiceInterface {

    var shouldFail = false
    var articlesToReturn: [Article] = []
    
    func fetchMostPopularArticles() -> AnyPublisher<[Article], Error> {
        if shouldFail {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        } else {
            return Just(articlesToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

extension Article {
   
    static func getMockArticles() -> [Article] {
        let article1 = Article(
            id: 20101,
            uri: "http://uniquearticle1.com/test/uri",
            url: "http://uniquearticle1.com/test/url",
            assetID: 21111,
            source: "newsletter",
            publishedDate: "05/05/2025",
            updated: "06/05/2025",
            section: "Environment",
            subsection: "Climate",
            nytdsection: "NYT",
            adxKeywords: "Climate Change,Sustainability",
            byline: "Article 1",
            type: "",
            title: "The Tipping Point of Climate Change",
            abstract: "By Rachel Greenfield",
            desFacet: ["Climate"],
            orgFacet: ["UN"],
            perFacet: ["Scientist"],
            geoFacet: ["Arctic"],
            media: nil,
            etaID: 2001
        )
        
        let article2 =  Article(
                id: 10102,
                uri: "http://article2.com/test/uri",
                url: "http://article2.com/test/url",
                assetID: 11112,
                source: "newswire",
                publishedDate: "02/05/2025",
                updated: "03/05/2025",
                section: "Science",
                subsection: "Space",
                nytdsection: "NYT",
                adxKeywords: "Space,NASA",
                byline: "Article 2",
                type: "",
                title: "Exploring Mars Again",
                abstract: "By Jane Doe",
                desFacet: ["Space"],
                orgFacet: ["NASA"],
                perFacet: ["Astronaut"],
                geoFacet: ["Mars"],
                media: nil,
                etaID: 1002
            )
        
        let article3 =  Article(
                id: 10103,
                uri: "http://article3.com/test/uri",
                url: "http://article3.com/test/url",
                assetID: 11113,
                source: "blog",
                publishedDate: "01/05/2025",
                updated: "02/05/2025",
                section: "Health",
                subsection: "Nutrition",
                nytdsection: "NYT",
                adxKeywords: "Health,Nutrition",
                byline: "Article 3",
                type: "",
                title: "The Plant-Based Trend",
                abstract: "By John Smith",
                desFacet: ["Nutrition"],
                orgFacet: ["WHO"],
                perFacet: ["Dietitian"],
                geoFacet: ["USA"],
                media: nil,
                etaID: 1003
            )
        
        let article4 =  Article(
                id: 10104,
                uri: "http://article4.com/test/uri",
                url: "http://article4.com/test/url",
                assetID: 11114,
                source: "social",
                publishedDate: "30/04/2025",
                updated: "01/05/2025",
                section: "Business",
                subsection: "Startups",
                nytdsection: "NYT",
                adxKeywords: "Business,Startups",
                byline: "Article 4",
                type: "",
                title: "Unicorns on the Rise",
                abstract: "By Sarah Lee",
                desFacet: ["Startups"],
                orgFacet: ["TechCrunch"],
                perFacet: ["Entrepreneur"],
                geoFacet: ["Silicon Valley"],
                media: nil,
                etaID: 1004
            )
        
            let article5 =  Article(
                id: 10105,
                uri: "http://article5.com/test/uri",
                url: "http://article5.com/test/url",
                assetID: 11115,
                source: "magazine",
                publishedDate: "28/04/2025",
                updated: "29/04/2025",
                section: "Culture",
                subsection: "Books",
                nytdsection: "NYT",
                adxKeywords: "Books,Literature",
                byline: "Article 5",
                type: "",
                title: "New Voices in Fiction",
                abstract: "By Emily Zhang",
                desFacet: ["Literature"],
                orgFacet: ["NYT Books"],
                perFacet: ["Author"],
                geoFacet: ["UK"],
                media: nil,
                etaID: 1005
            )
        
        return [article1, article2, article3, article4, article5]
    }
}
