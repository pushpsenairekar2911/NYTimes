//
//  NYNetworkServiceInterface.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Foundation

public protocol NYNetworkServiceInterface {
    func request<T: Decodable>(endPoint: NYEndPoint, retries: Int) async throws -> T
}

public enum NYNetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Int)
    case unknown
}

// MARK: - METHOD'S TYPE
public enum NYHTTPMethod: String {
    case get = "GET"
}

// MARK: - BASE URL
public enum NYBaseURL: String {
    case baseURL = "api.nytimes.com"
}

// MARK: - PATH
public enum NYAPIPath: String {

    case getMostPopularArticles = "/svc/mostpopular/v2/mostviewed/all-sections/7.json"
    case invalidURL = "invalid-url"
}

public protocol NYEndPoint {

    var path: NYAPIPath { get set }
    var method: NYHTTPMethod { get set }
    var baseURL: NYBaseURL { get set }
    var paramters: [String: String]? { get set }
    var url: URL? { get }
}

public struct NYEndPointImplmentation: NYEndPoint {

    public var path: NYAPIPath = .getMostPopularArticles
    public var method: NYHTTPMethod = .get
    public var baseURL: NYBaseURL = .baseURL
    public var paramters: [String : String]?

    public var url: URL? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL.rawValue
        components.path = path.rawValue
        components.queryItems = paramters?.map { URLQueryItem(name: $0.key, value: $0.value )}
        return components.url
    }
}
