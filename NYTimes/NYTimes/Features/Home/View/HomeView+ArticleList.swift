//
//  HomeView+ArticleList.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 04/05/25.
//

import SwiftUI

extension HomeView {
    
    // MARK: - Build Article List
    @ViewBuilder func buildArticleList(
        articles: [ArticlePresentationObject]
    ) -> some View {
        List(articles) { article in
            buildListItem(
                article: article
            )
            .padding(.top, 5)
            .padding(.horizontal)
            .onTapGesture {
                viewModel.didTapOnArticle(
                    articleId: article.id
                )
            }
            .listRowSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}
