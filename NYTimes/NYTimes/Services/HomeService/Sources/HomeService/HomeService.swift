
import NYNetworkingService
import Foundation
import Combine


// Article repository implementation
public class HomeService: HomeServiceInterface {
    
    private let networkService: NYNetworkServiceInterface
    private let apiKey: String
    
    private let dataProviderSubject: CurrentValueSubject<[Article]?, Never> = .init(nil)
    
    public init(
        networkService: NYNetworkServiceInterface
    ) {
        self.networkService = networkService
        apiKey = ServiceConstants.apiKey
    }
    
    func internalFetchMostPopularArticles() async throws -> [Article] {
        let parameters = ["api-key": apiKey]
        let endPoint = NYNetworkServiceEndpointBuilder()
            .setPath(.getMostPopularArticles)
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .setParameters(parameters)
            .build()
        let response: Articles = try await networkService.request(endPoint: endPoint, retries: 1)
        return response.results ?? []
    }
    
    public func fetchMostPopularArticles() -> AnyPublisher<[Article], Error> {
        Future { promise in
            Task {
                do {
                    let results = try await self.internalFetchMostPopularArticles()
                    promise(.success(results))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
