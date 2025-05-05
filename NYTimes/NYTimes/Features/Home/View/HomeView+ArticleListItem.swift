//
//  HomeView+ArticleListItem.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 04/05/25.
//

import NYKit
import SwiftUI

extension HomeView {
    // MARK: - Build Article List Item
    @ViewBuilder
    func buildListItem(
        article: ArticlePresentationObject
    ) -> some View {
        VStack(alignment: .leading) {
            // Image
            buildImageView(
                imageSource: article.thumbnail
            ).frame(height: screenWidth/1.8)
            
            VStack(alignment: .leading,
                   spacing: 12) {
                // Title & Subtitle
                buildTitleSubtitle(
                    title: article.headline,
                    subtitle: article.description
                )
                // Footer
                buildFooterView(
                    writtenBy: article.author,
                    writtenOn: article.writtenOn
                )
            }.padding()
        }
        .contentShape(Rectangle())
        .clipped()
        .background {
            Rectangle()
                .foregroundColor(Color(.systemFill).opacity(0.5))
        }
    }
    
    @ViewBuilder
    func buildTitleSubtitle(
        title: String?,
        subtitle: String?
    ) -> some View {
        VStack(alignment: .leading,
               spacing: 12) {
            if let title {
                Text(title)
                    .foregroundColor(.primary)
                    .font(.typeWriterBoldFont(size: 22))
                    .multilineTextAlignment(.leading)
            }
            if let subtitle {
                Text(subtitle)
                    .foregroundColor(.secondary)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    @ViewBuilder
    func buildFooterView(
        writtenBy: String?,
        writtenOn: String?
    ) -> some View {
        HStack(spacing: 6) {
            if let writtenBy {
                HStack(spacing: 6) {
                    Image(systemName: SystemImageConstants.clipboard)
                        .font(.system(size: 14))
                        .tint(.primary)
                    
                    Text(writtenBy)
                        .foregroundColor(.primary)
                        .font(.system(size: 14))
                        .padding(2)
                        .lineLimit(1)
                }
                .padding(5)
                .background {
                    RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                        .foregroundColor(Color(.systemFill))
                }
            }
            
            if let writtenOn {
                HStack(spacing: 6) {
                    Image(systemName: SystemImageConstants.calendar)
                        .font(.system(size: 14))
                        .tint(.primary)
                    
                    Text(writtenOn)
                        .foregroundColor(.primary)
                        .font(.system(size: 14))
                        .padding(2)
                        .lineLimit(1)
                }
                .padding(5)
                .background {
                    RoundedRectangle(cornerSize: CGSize(width: 6, height: 6))
                        .foregroundColor(Color(.systemFill))
                }
            }
            
            Spacer()
            
            Image(systemName: SystemImageConstants.chevronForward)
                .font(.system(size: 16))
                .tint(.primary)
            
        }.frame(height: 32)
    }
}

extension HomeView {
    @ViewBuilder
    func buildImageView(
        imageSource: NYImageSource?
    ) -> some View {
        if let imageSource {
            switch imageSource {
            case .localImage(let name):
                Image.fromName(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: screenWidth - 32,
                        height: (screenWidth - 32/5),
                        alignment: .center
                    )
            case .remote(let url):
                NYURLImage(presentationObject:
                        .init(urlStr: url,
                              contentMode: .fit
                             )
                )
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: screenWidth - 32,
                    height: (screenWidth - 32/5),
                    alignment: .center
                )
            }
        }
    }
}
