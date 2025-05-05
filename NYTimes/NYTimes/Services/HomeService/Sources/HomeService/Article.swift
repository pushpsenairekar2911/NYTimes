//
//  Article.swift
//  HomeService
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import Foundation
import Combine



public struct Article: Codable , Sendable, Identifiable, Equatable {
    
    public let id: Int
    public let uri: String?
    public let url: String?
    public let assetID: Int?
    public let source: String?
    public let publishedDate: String?
    public let updated: String?
    public let section: String?
    public let subsection: String?
    public let nytdsection: String?
    public let adxKeywords: String?
    public let byline: String?
    public let type: String?
    public let title: String?
    public let abstract: String?
    public let desFacet: [String]?
    public let orgFacet: [String]?
    public let perFacet: [String]?
    public let geoFacet: [String]?
    public let media: [Media]?
    public let etaID: Int?
    
    public enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case type
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case title, abstract, byline
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
    
    public var imageURL: String? {
        guard
            let media = media,
            let last = media.last?.mediaMetadata?.last,
            let articleImageURL = last.url else { return nil }
        return articleImageURL
    }
    
    public init(id: Int, uri: String?, url: String?, assetID: Int?, source: String?, publishedDate: String?, updated: String?, section: String?, subsection: String?, nytdsection: String?, adxKeywords: String?, byline: String?, type: String?, title: String?, abstract: String?, desFacet: [String]?, orgFacet: [String]?, perFacet: [String]?, geoFacet: [String]?, media: [Media]?, etaID: Int?) {
        self.id = id
        self.uri = uri
        self.url = url
        self.assetID = assetID
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaID = etaID
    }
    
    // MARK: - Media
    public struct Media: Codable, Equatable, Sendable {
        
        public struct MediaMetadata: Codable, Equatable, Sendable {
            public let url: String?
            public let format: Format?
            public let height, width: Int?
        }
        
        public enum Format: String, Codable, Sendable {
            case mediumThreeByTwo210 = "mediumThreeByTwo210"
            case mediumThreeByTwo440 = "mediumThreeByTwo440"
            case standardThumbnail = "Standard Thumbnail"
        }
        
        public enum Subtype: String, Codable, Equatable, Sendable {
            case empty = ""
            case photo = "photo"
        }
        
        public enum MediaType: String, Codable, Equatable, Sendable {
            case image = "image"
        }
        
        public let type: MediaType?
        public let subtype: Subtype?
        public let caption, copyright: String?
        public let approvedForSyndication: Int?
        public let mediaMetadata: [MediaMetadata]?
        
        enum CodingKeys: String, CodingKey {
            case type, subtype, caption, copyright
            case approvedForSyndication = "approved_for_syndication"
            case mediaMetadata = "media-metadata"
        }
    }
}

public struct Articles: Decodable, Equatable, Sendable {
    
    let status, copyright: String?
    let count: Int?
    let results: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case count = "num_results"
        case results
    }
    
    public static func == (lhs: Articles, rhs: Articles) -> Bool {
        return lhs.status == rhs.status && lhs.copyright == rhs.copyright && lhs.count == rhs.count && lhs.results == rhs.results
    }
}
