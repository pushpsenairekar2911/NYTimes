//
//  AppDelegate.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import SwiftUI
import NYNetworkingService
import HomeService

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    var homeService : HomeService?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //MARK: - Allocating Services
        let networkService = NYNetworkService()
        let homeService = HomeService(networkService: networkService)
        self.homeService = homeService
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        return true
    }
}
