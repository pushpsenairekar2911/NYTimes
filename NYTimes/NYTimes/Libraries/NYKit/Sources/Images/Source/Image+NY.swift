//
//  Image+NY.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Foundation
import SwiftUI

// MARK: - Styled backgrounds
public extension Image {
    static let nyOnboardingBackground = Image("onboarding-background", bundle: .module)
    static let nyTextLogo = Image("text-logo", bundle: .module)
    static let logo = Image("logo", bundle: .module)
}


public extension Image {
    static func fromName(_ name: String, bundle: Bundle? = nil) -> Image {
        Image(name, bundle: bundle ?? .module)
    }
}

/// Image source for local or remote image
public enum NYImageSource: Equatable , Sendable {
    case localImage(name: String)
    case remote(url: String)
}

public enum NYImageName: Equatable , Sendable {
    case system(name: String)
    case local(name: String)
}

/// Presentation object for any image icon in the app views
public struct NYImagePresentationObject: Equatable, Sendable {
    public let imageName: NYImageName
    public let imageForgroundColor: Color?
    public let imageBackgroundColor: Color?
    public let imageSize: CGSize?
    
    public init(
        imageName: NYImageName,
        imageForgroundColor: Color? = nil,
        imageBackgroundColor: Color? = nil,
        imageSize: CGSize? = CGSize(width: 24, height: 24)
    ) {
        self.imageName = imageName
        self.imageForgroundColor = imageForgroundColor
        self.imageBackgroundColor = imageBackgroundColor
        self.imageSize = imageSize
    }
}
