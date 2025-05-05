//
//  NYScrollView.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI

// A ScrollView wrapper that tracks scroll offset changes.
public struct NYScrollView<Content>: View where Content : View {
    @Namespace var scrollSpace
    @Binding var scrollYOffset: CGFloat
    
    let axes: Axis.Set
    let showsIndicators: Bool
    let content: (ScrollViewProxy) -> Content
    
    public init(axes: Axis.Set = .vertical,
                showsIndicators: Bool = true,
                scrollYOffset: Binding<CGFloat>,
                @ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        _scrollYOffset = scrollYOffset
        self.content = content
    }
    
    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).origin.y
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self,
                                        value: offset)
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            DispatchQueue.main.async {
                scrollYOffset = value
            }
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

