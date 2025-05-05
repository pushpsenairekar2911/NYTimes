//
//  OnboardingViewModelEvent.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 04/05/25.
//

import SwiftUI
import Combine
import Foundation

// MARK: - ViewModel Event
/// View model publishes these events to the subcribers (typically coordinators) to communicate any action
public enum OnboardingViewModelEvent {
    case didTapOnGetStarted
}


// MARK: - HomePresentationObject
/// Amazon pay later card
public struct OnboardingPresentationObject: Sendable {
    
    let currentDate: String
    
}
