//
//  HomeDetails+TitleView.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI

extension HomeDetails {
    
    @ViewBuilder
    func buildTitle(
        title: String?
    ) -> some View {
        if let title {
            VStack {
                Text(title)
                    .foregroundColor(.primary)
                    .font(.typeWriterBoldFont(size: 24))
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    @ViewBuilder
    func buildDescription(
        text: String?
    ) -> some View {
        if let text {
            Text(text)
                .foregroundColor(.primary)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.top, 6)
        }
    }
    
}
