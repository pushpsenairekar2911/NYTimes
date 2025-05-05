//
//  NYNetworkServiceEndpointBuilder.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Foundation

public class NYNetworkServiceEndpointBuilder {
    
    private var path: NYAPIPath = .getMostPopularArticles
    private var method: NYHTTPMethod = .get
    private var baseURL: NYBaseURL = .baseURL
    private var parameters: [String: String] = [:]
    
    public init() { }
    
    public init(
        path: NYAPIPath,
        method: NYHTTPMethod,
        baseURL: NYBaseURL,
        parameters: [String : String]) {
            self.path = path
            self.method = method
            self.baseURL = baseURL
            self.parameters = parameters
        }
    
    @discardableResult
    public func setPath(_ value: NYAPIPath) -> Self {
        self.path = value
        return self
    }
    
    // set the HTTPMethod.
    @discardableResult
    public func setMethod(_ value: NYHTTPMethod) -> Self {
        self.method = value
        return self
    }
    
    // set the BaseURL.
    @discardableResult
    public func setBaseURL(_ value: NYBaseURL) -> Self {
        self.baseURL = value
        return self
    }
    
    // set the Parameters.
    @discardableResult
    public func setParameters(_ value: [String: String]) -> Self {
        self.parameters = value
        return self
    }
    
    public func build() -> NYEndPoint {
        var endpoint = NYEndPointImplmentation()
        endpoint.method = method
        endpoint.path = path
        endpoint.baseURL = baseURL
        endpoint.paramters = parameters
        return endpoint
    }
    
}
