//
//  Onboarding.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 04/05/25.
//

import SwiftUI
import NYKit

struct OnboardingView: View {
    
    @StateObject var viewModel : OnboardingViewModel
    
    var body: some View {
        VStack {
            // MARK: - Background
            buildBackground()
                .overlay {
                    VStack {
                        
                        Spacer()
                        buildLogo()
                        buildDate(
                            date: viewModel.presentationObject.currentDate
                        )
                        Spacer()
                        
                        // MARK: - Button
                        buildButton()
                    }.offset(y: -40)
                }
        }
    }
}

extension OnboardingView {
    
    @ViewBuilder
    private func buildBackground() -> some View {
        Image.nyOnboardingBackground
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fill)
    }
    
    @ViewBuilder
    private func buildLogo() -> some View {
        Image.nyTextLogo
            .renderingMode(.template)
            .foregroundColor(.white)
            .padding(.horizontal)
        
    }
    
    @ViewBuilder
    private func buildDate(date: String) -> some View {
        Text(date)
            .foregroundColor(.white)
            .font(.system(size: 18))
    }
    
    @ViewBuilder
    private func buildButton() -> some View {
        Button {
            viewModel.didTapOnGetStarted()
        } label: {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(height: 50)
                .overlay {
                    HStack {
                        Spacer()
                        Text(Constants.getStartedText)
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                        
                        Spacer()
                        
                        Image(systemName: SystemImageConstants.arrowForward)
                            .tint(.black)
                            .font(.system(size: 18))
                            .padding(.trailing)
                    }
                }
        }.padding(.bottom)
         .padding()

    }
}
