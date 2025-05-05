
import Combine
import Foundation
import NYNetworkingService

public final class HomeService: HomeServiceInterface {
    
    private let httpClient: HttpClientInterface
    
    public init(
        httpClient: HttpClientInterface
    ) {
        self.httpClient = httpClient
    }
    
//    public var articlesPublisher: AnyPublisher<[NYNetworkingService.Article]?, Never> {
//        return ([], nil)
//    }
    
    public func fetchMostPopularArticles() async -> ([NYNetworkingService.Article]?, NYAPIError?) {
        do {
            guard let mostPopularArticlesResponse = try await internalFetchMostPopularArticles() else {
                return ([], .unknown)
            }
            
            print("mostPopularArticlesResponse: \(mostPopularArticlesResponse)")
            
          //  return (mostPopularArticlesResponse, nil)
            
        } catch {
            // Handle network or retriable errors
        }
        return ([], .unknown)
    }
    
    private func internalFetchMostPopularArticles() async throws -> GetMostPopularArticlesResponse? {
        do {
            let endpoint = GetMostPopularArticlesEndpoint()
            
            let response = try await httpClient.runRequestForEndpoint(endpoint)
            return response
            
        }  catch let error as NYAPIError {
            // TODO: - Handle error, retry etc.
            throw error
        }
    }
}
