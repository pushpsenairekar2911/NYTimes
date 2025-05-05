//
//  HomeView+FailureView.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI

extension HomeView {
    // MARK: - Build Failure View
    @ViewBuilder
    func buildFailureView() -> some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .font(.system(size: 32))
            
            Text("Failed to fetch articles")
        }
    }
}
