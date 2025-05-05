//
//  HomeDetails+Detail.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 05/05/25.
//
import SwiftUI

extension HomeDetails {
    
    @ViewBuilder
    func buildDisclosureGroup(
        author: String?,
        date: String?,
        section: String?,
        subSection: String?
    ) -> some View {
        GroupBox() {
            DisclosureGroup(Constants.articleDetailsText, isExpanded: $isExpanded) {
                // Author
                if let author {
                    Divider().padding(.vertical, 2)
                    buildItem(
                        title: Constants.authorText,
                        systemIcon: SystemImageConstants.clipboard,
                        desciption: author
                    )
                }
                
                // Section
                if let section {
                    Divider().padding(.vertical, 2)
                    buildItem(
                        title: Constants.sectionText,
                        systemIcon: SystemImageConstants.region,
                        desciption: section
                    )
                }
                
                // subSectionText
                if let subSection {
                    Divider().padding(.vertical, 2)
                    buildItem(
                        title: Constants.subSectionText,
                        systemIcon: SystemImageConstants.flag,
                        desciption: subSection
                    )
                }
                
                // Published On
                if let date {
                    Divider().padding(.vertical, 2)
                    buildItem(
                        title: Constants.publishOnText,
                        systemIcon: SystemImageConstants.calendar,
                        desciption: date
                    )
                }
            }.background(Color.clear)
             .frame(maxHeight: isExpanded == false ? 20 : .infinity)
        }.tint(.primary)
         .padding(.horizontal)
    }
    
    private func buildItem(title: String,
                           systemIcon: String,
                           desciption: String) -> some View  {
        HStack {
            Group {
                Image(systemName: systemIcon)
                Text(title)
            }
            .foregroundColor(.primary)
            .font(.system(size: 16, weight: .regular))
            
            Spacer(minLength: 10)
            
            Text(desciption)
                .font(.system(size: 16))
                .multilineTextAlignment(.trailing)
        }
    }
}
