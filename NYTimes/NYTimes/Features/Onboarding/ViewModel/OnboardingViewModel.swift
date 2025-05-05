//
//  OnboardingViewModel.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 04/05/25.
//

import Combine
import Foundation

open class OnboardingViewModel:  ObservableObject {
    
    @Published var presentationObject: OnboardingPresentationObject = .init(
        currentDate: ""
    )
    
    private let viewModelEventSubject: PassthroughSubject<OnboardingViewModelEvent, Never> = .init()
    
    open var viewModelEvent: AnyPublisher<OnboardingViewModelEvent, Never> {
        viewModelEventSubject.eraseToAnyPublisher()
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    private let date = Date()
    
    init() {
        makePresentationObject()
    }
    
    func getCurrentDate() -> String {
        dateFormatter.string(from: date)
    }
    
    func makePresentationObject() {
        return presentationObject = .init(
            currentDate: getCurrentDate()
        )
    }
    
    func didTapOnGetStarted() {
        self.viewModelEventSubject.send(.didTapOnGetStarted)
        self.viewModelEventSubject.send(completion: .finished)
    }
}
