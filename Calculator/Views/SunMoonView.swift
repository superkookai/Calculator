//
//  SunMoonView.swift
//  Calculator
//
//  Created by Weerawut Chaiyasomboon on 29/2/2567 BE.
//

import SwiftUI

struct SunMoonView: View {
    var lightMode: Bool
    
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: "sun.min")
                .foregroundStyle(lightMode ? .sunOrMoonSelected : .sunOrMoonNotSelected)
            Image(systemName: "moon")
                .foregroundStyle(lightMode ? .sunOrMoonNotSelected : .sunOrMoonSelected)
        }
        .imageScale(.large)
        .font(UIDevice.isIPad ? .title : .body)
        .fontWeight(UIDevice.isIPad ? .semibold : .regular)
        .padding()
        .background(
            .secondaryBackground
        )
        .cornerRadius(20)
    }
}

#Preview {
    VStack {
        SunMoonView(lightMode: true)
        SunMoonView(lightMode: false)
    }
}
