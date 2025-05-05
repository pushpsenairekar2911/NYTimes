//
//  HomeDetails+Thumbnail.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//

import SwiftUI
import NYKit

extension HomeDetails {
    
    @ViewBuilder
    func buildImageView(
        imageSource: NYImageSource?
    ) -> some View {
        if let imageSource {
            switch imageSource {
            case .localImage(let name):
                Image.fromName(name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: screenWidth,
                        height: (screenWidth/1.6),
                        alignment: .center
                    )
            case .remote(let url):
                NYURLImage(presentationObject:
                        .init(urlStr: url,
                              contentMode: .fill
                             )
                )
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: screenWidth,
                    height: (screenWidth/1.6),
                    alignment: .center
                )
            }
        }
    }
}
