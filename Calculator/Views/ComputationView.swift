//
//  ComputationView.swift
//  Calculator
//
//  Created by Weerawut Chaiyasomboon on 29/2/2567 BE.
//

import SwiftUI

struct ComputationView: View {
    let currentComputation: String
    let mainResult: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text(currentComputation)
                    .font(UIDevice.isIPad ? .largeTitle : .body)
                    .foregroundStyle(.foregroundDigits)
                    .lineLimit(1)
            }
            .minimumScaleFactor(0.1)
            
            HStack {
                Spacer()
                Text(mainResult)
                    .foregroundStyle(.foregroundDigits)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            .minimumScaleFactor(0.1)
        }
        .padding(.horizontal)
    }
}

#Preview {
    VStack(spacing: 30) {
        ComputationView(currentComputation: "12000+926", mainResult: "12926")
        ComputationView(currentComputation: "76%", mainResult: "0.76")
        ComputationView(currentComputation: "12x11", mainResult: "132")
    }
}
