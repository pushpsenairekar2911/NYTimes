//
//  HomeServiceInterface.swift
//  HomeService
//
//  Created by Pushpsen Airekar on 04/05/25.
//

import Combine
import NYNetworkingService

public protocol HomeServiceInterface: AnyObject {
    
 //   var articlesPublisher: AnyPublisher<[Article]?, Never> { get }
    
    func fetchMostPopularArticles() async -> ([Article]?, NYAPIError?)
    
    
//    /// Image service provider
//    var imageServiceProvider: ImageServiceProviderInterface { get }
}
