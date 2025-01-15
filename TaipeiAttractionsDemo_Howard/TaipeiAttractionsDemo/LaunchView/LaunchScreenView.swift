//
//  LaunchScreenView.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/14.
//

import Foundation
import SwiftUI

struct LaunchScreenView: View {
    
    @State private var firstAnimation = false
    @State private var secondAnimation = false
    @State private var startFadeoutAnimation = false
    @State private var lsStatus = LaunchScreenStep.firstStep
    @State private var count = 10
    
    @ViewBuilder
    private var image: some View {
        Image(systemName: "circle.dotted.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .rotationEffect(firstAnimation ? Angle(degrees: 0) : Angle(degrees: 1800))
            .scaleEffect(secondAnimation ? 0 : 1)
            .offset(y: secondAnimation ? 500 : 0)
    }
    
    @ViewBuilder
    private var backgroundColor: some View {
        Color("SwiftUIColor").ignoresSafeArea()
    }
    
    private let animationTimer = Timer
        .publish(every: 0.3, on: .current, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor
            image
        }.onReceive(animationTimer) { timerValue in
            updateAnimation()
            
            self.count = self.count - 1
            if count == 0 {
                self.lsStatus = .secondStep
            }
            
        }.opacity(startFadeoutAnimation ? 0 : 1)
    }
    
    private func updateAnimation() {
        
        switch self.lsStatus {
        case .firstStep:
            withAnimation(.easeInOut(duration: 5)) {
                firstAnimation.toggle()
            } completion: {
                
            }
        case .secondStep:
            if secondAnimation == false {
                withAnimation(.linear) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                    self.lsStatus = .finished
                } completion: {
                    
                }
            }
        case .finished:
            break
        }
    }
}

//struct LaunchScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchScreenView()
//            .environmentObject(LaunchScreenStateManager())
//    }
//}
