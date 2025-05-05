//
//  NetworkService.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Foundation

// API Service implementation
public class NYNetworkService: NYNetworkServiceInterface {
    
    private var session: URLSession
    private let decoder: JSONDecoder
    
    public init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = urlSession
        self.decoder = decoder
    }
    
    public func request<T: Decodable>(
        endPoint: NYEndPoint,
        retries: Int = 3
    ) async throws -> T {
        guard let url = endPoint.url else {
            throw NYNetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        urlRequest.timeoutInterval = 30
        
        do {
            let (data, response) = try await executeRequest(urlRequest, remainingRetries: retries)
            return try decode(data: data, response: response)
        } catch {
            throw handleError(error)
        }
    }
    
    private func executeRequest(_ request: URLRequest, remainingRetries: Int) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch {
            if remainingRetries > 0 {
                try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
                return try await executeRequest(request, remainingRetries: remainingRetries - 1)
            }
            throw error
        }
    }
    
    private func decode<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NYNetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NYNetworkError.decodingError
            }
        default:
            throw NYNetworkError.serverError(httpResponse.statusCode)
        }
    }
    
    private func handleError(_ error: Error) -> Error {
        if let networkError = error as? NYNetworkError {
            return networkError
        }
        return NYNetworkError.unknown
    }
}
