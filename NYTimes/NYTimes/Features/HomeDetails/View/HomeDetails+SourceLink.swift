//
//  ArticleDetails+SourceLink.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI

extension HomeDetails {
    
    @ViewBuilder
    func buildSourceLinkView(source: String?,
                             link: String?) -> some View {
        if let source, let link {
            VStack {
                HStack {
                    Text(Constants.visitAlsoText)
                    Spacer()
                }
                
                GroupBox() {
                    HStack {
                        Text(Constants.contentSourceText)
                        Spacer()
                        Link(source, destination: URL(string: link)!)
                        Image(systemName: SystemImageConstants.arrowUpRight)
                    }
                    .font(.footnote)
                }
            }.padding(.horizontal)
        }
    }
    
}
