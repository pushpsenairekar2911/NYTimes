//
//  HomeView.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel : HomeViewModel
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        buildContentView()
    }
}

extension HomeView {
    // MARK: - Build Content View
    @ViewBuilder
    private func buildContentView() -> some View {
        VStack {
            switch viewModel.presentationObject.state {
            case .failed:
                buildFailureView()
            case .loading:
                buildLoadingView()
            case .loaded(let articles):
                buildArticleList(
                    articles: articles
                )
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                buildTitleView()
            }
        }
    }
    
    // MARK: - Build Title View
    @ViewBuilder
    private func buildTitleView() -> some View {
        Image.nyTextLogo
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 30)
    }
    
    // MARK: - Build Search Icon
    @ViewBuilder
    private func buildSearchIcon() -> some View {
        Image(systemName: SystemImageConstants.magnifyingGlass)
            .font(.system(size: 16))
    }
}
