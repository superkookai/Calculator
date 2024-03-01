//
//  ContentView.swift
//  Calculator
//
//  Created by Weerawut Chaiyasomboon on 29/2/2567 BE.
//

import SwiftUI

struct MainCalculatorView: View {
    @State private var lightMode: Bool = true
    @State private var currentComputation: String = ""
    @State private var mainResult: String = "0"
    
    var body: some View {
        ZStack {
            Color(.primaryBackground)
                .ignoresSafeArea()
            
            VStack {
                SunMoonView(lightMode: lightMode)
                    .onTapGesture {
                        withAnimation{
                            lightMode.toggle()
                        }
                    }
                
                Spacer()
                
                ComputationView(currentComputation: currentComputation, mainResult: mainResult)
                
                Spacer()
                
                CalcButtonsView(currentComputation: $currentComputation, mainResult: $mainResult)
                
                if UIDevice.isIPad{
                    Spacer()
                }
            }
            .padding()
        }
        .environment(\.colorScheme, lightMode ? .light : .dark)
    }
}

#Preview {
    MainCalculatorView()
}
