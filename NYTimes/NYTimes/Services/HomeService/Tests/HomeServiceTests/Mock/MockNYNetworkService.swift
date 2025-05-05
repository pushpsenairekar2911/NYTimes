//
//  MockHomeServiceInterface.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/10/24.
//


import NYNetworkingService
import HomeService
import Foundation

class MockNYNetworkService: NYNetworkServiceInterface {

    var shouldReturnError = false
    var articles: Articles?

    func request<T>(endPoint: any NYNetworkingService.NYEndPoint, retries: Int) async throws -> T where T : Decodable {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
        }
        guard let response = articles as? T else {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No articles returned"])
        }
        return response
    }
}
