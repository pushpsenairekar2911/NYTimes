//
//  HomeDetails.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 04/05/25.
//

import SwiftUI
import SwiftData
import NYKit

struct HomeDetails: View {
    
    @StateObject var viewModel : HomeDetailsViewModel
    @State var isExpanded : Bool = true
    @State var headerScale: CGFloat = 0
    @State var verticalOffset: CGFloat = 0.0
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        buildContentView()
    }
}

extension HomeDetails {
    
    @ViewBuilder
    private func buildContentView() -> some View {
        VStack {
            switch viewModel.presentationObject.state {
            case .failed: EmptyView()
            case .loading:  EmptyView()
            case .loaded(let article):
                buildArticleView(
                    article: article
                )
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private func buildArticleView(
        article: ArticleDetailPresentationObject
    ) -> some View {
        NYScrollView(
            showsIndicators: false,
            scrollYOffset: $verticalOffset
        ) { _ in
            LazyVStack {
                // Thumbnail
                buildImageView(
                    imageSource: article.thumbnail 
                )
                .scaleEffect(headerScale)
                .overlay {
                    VStack {
                        HStack(alignment: .top) {
                            Button {
                                viewModel.didTapOnNavigationBack()
                            } label: {
                                Image(
                                    systemName: SystemImageConstants.chevronLeft
                                )
                                .font(.system(size: 18))
                                .tint(.white)
                            }
                            .frame(width: 40, height: 40)
                            .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                    .safeAreaPadding(.top)
                    .padding(.top)
                }
                
                //Headline
                buildTitle(title: article.headline)
                
                // Detail Dropdown
                buildDisclosureGroup(
                    author: article.author,
                    date: article.writtenOn,
                    section: article.section,
                    subSection: article.subSection
                )
                
                //Description
                buildDescription(
                    text: article.description
                )
                
                Divider()
                
                // Source link
                buildSourceLinkView(
                    source: article.source,
                    link: article.navigationLink
                )
            }
        }
        .onChange(of: verticalOffset) {
            withAnimation(.easeInOut(duration: 0.4)) {
                headerScale = 1 - min(200, verticalOffset) / 200
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.7)) {
                headerScale = 1
            }
        }
        .ignoresSafeArea()
    }
}
