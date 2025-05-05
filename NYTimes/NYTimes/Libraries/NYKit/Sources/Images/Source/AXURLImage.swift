//
//  NYURLImage.swift
//  NYKit
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import URLImage
import SwiftUI
import Shimmer

public struct NYURLImage: View {
    @Environment(\.colorScheme) var colorScheme
    
    public typealias PrimaryButtonTapHandler = () -> Void
    
    private let onPrimaryButtonTapCallback: PrimaryButtonTapHandler?
    private let presentationObject: URLImagePresentationObject
    
    public init(
        presentationObject: URLImagePresentationObject,
        onPrimaryButtonTapCallback: PrimaryButtonTapHandler? = nil
    ) {
        self.presentationObject = presentationObject
        self.onPrimaryButtonTapCallback = onPrimaryButtonTapCallback
    }
    
    public var body: some View {
        URLImage(URL(string: presentationObject.urlStr) ?? URL(string: "urlnotfound")!) { _ in
            // Placeholder view
                placeHolderView(size: presentationObject.placeholderSize ?? .zero)
        } failure: { error, retry in
            // Display error and retry
            if presentationObject.showCustomPlaceholder {
                buildTextInitialsView(
                    with: presentationObject.customPlaceholderText ?? "",
                    textColor: presentationObject.tint,
                    textFont: presentationObject.customPlaceholderFont
                )
            } else {
                placeHolderView(size: presentationObject.placeholderSize ?? .zero)
             }
        } content: { image in
            // Downloaded image
                buildImageView(
                    with: image,
                    tint: presentationObject.tint
                )
        }
    }
    
    private func buildImageView(
        with image: Image,
        tint: Color? = nil
    ) -> some View {
        image
            .resizable()
            .renderingMode(tint != nil ? .template : .original)
            .frame(width: presentationObject.size?.width,
                   height: presentationObject.size?.height)
            .aspectRatio(contentMode: presentationObject.contentMode)
            .foregroundColor(tint)
            .clipped()
    }
    
    private func buildTextInitialsView(
        with text: String,
        textColor: Color? = nil,
        textFont: Font?
    ) -> some View {
        Text(text)
            .font(textFont)
            .foregroundColor(textColor)
            .frame(width: presentationObject.size?.width,
                   height: presentationObject.size?.height)
    }
}

// MARK: - URLImagePresentationObject
public struct URLImagePresentationObject: Equatable , Sendable {
    let urlStr: String
    let contentMode: ContentMode
    let size: CGSize?
    let placeholderSize: CGSize?
    let tint: Color?
    let customPlaceholderText: String?
    let customPlaceholderFont: Font?
    let showCustomPlaceholder: Bool
    
    public init(
        urlStr: String,
        contentMode: ContentMode = .fit,
        size: CGSize? = nil,
        placeholderSize: CGSize? = nil,
        tint: Color? = nil,
        customPlaceholderText: String? = nil,
        customPlaceholderFont: Font? = .typeWriterFont(size: 18),
        showCustomPlaceholder: Bool = false
    ) {
        self.urlStr = urlStr
        self.contentMode = contentMode
        self.size = size
        self.placeholderSize = placeholderSize
        self.tint = tint
        self.customPlaceholderText = customPlaceholderText
        self.customPlaceholderFont = customPlaceholderFont
        self.showCustomPlaceholder = showCustomPlaceholder
    }
}

extension View {
    public func placeHolderView(size: CGSize, color: Color = Color.secondary) -> some View {
        VStack {  EmptyView() }
            .frame(width: size.width, height: size.height)
            .background(color.opacity(0.6))
            .clipped()
            .shimmering(
                gradient:  Gradient(colors: [Color.secondary.opacity(0.2),
                                             Color.secondary.opacity(0.7),
                                             Color.secondary.opacity(0.2)]),
                bandSize: 0.8
            )
    }
}
