//
//  NYTimesApp.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI
import SwiftData
import NYNetworkingService

@main
struct NYTimesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnboardingCoordinator(
                homeService: appDelegate.homeService ?? .init(networkService: NYNetworkService())
            ).start()
        }
    }
}


