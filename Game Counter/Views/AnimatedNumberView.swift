//
//  AnimatedNumberView.swift
//  AnimatedNumberView
//
//  Created by Adam Garrett-Harris on 9/9/21.
//

import SwiftUI

struct AnimatedNumberView: View {
    @State var number: Int
    var animationTime: Int
    
    @State private var isAnimating = false
    
    var body: some View {
        Text("\(number > 0 ? "+" : "")\(number)")
            .foregroundColor(Color("AccentColor"))
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: Double(animationTime) / 1000))
            .offset(x: 0, y: isAnimating ? -50 : 0)
            .onAppear {
                isAnimating = true
            }
    }
}

struct AnimatedNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedNumberView(number: 1, animationTime: 500)
    }
}
