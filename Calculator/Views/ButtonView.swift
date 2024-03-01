//
//  ButtonView.swift
//  Calculator
//
//  Created by Weerawut Chaiyasomboon on 29/2/2567 BE.
//

import SwiftUI

struct ButtonView: View {
    let calcButton: CalcButton
    let fgColor: Color
    let bgColor: Color
    
    var systemImage: String?{
        let value = calcButton.rawValue
        return value.contains("IMG") ? value.replacingOccurrences(of: "IMG", with: "") : nil
    }
    
    var text: String?{
        let value = calcButton.rawValue
        return value.contains("IMG") ? nil : value
    }
    
    let buttonDim: CGFloat = UIDevice.isIPad ? UIScreen.main.bounds.width / 6 : UIScreen.main.bounds.width / 5
    
    var body: some View {
        ZStack {
            if let text = text{
                Text(text)
            }
            if let systemImage = systemImage{
                Image(systemName: systemImage)
            }
        }
        .font(UIDevice.isIPad ? .largeTitle : .title2)
        .fontWeight(UIDevice.isIPad ? .bold : .semibold)
        .frame(width: buttonDim, height: buttonDim)
        .foregroundStyle(fgColor)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(bgColor)
                .shadow(color: bgColor.opacity(0.5), radius: 3, x: 5, y: 5)
        )
        
    }
}

#Preview {
    VStack {
        ButtonView(calcButton: .one, fgColor: .foregroundDigits, bgColor: .buttonBackground)
        
        ButtonView(calcButton: .percent, fgColor: .foregroundTopButtons, bgColor: .buttonBackground)
        
        ButtonView(calcButton: .add, fgColor: .foregroundRightButtons, bgColor: .buttonBackground)
        
        ButtonView(calcButton: .undo, fgColor: .foregroundRightButtons, bgColor: .buttonBackground)
        
        ButtonView(calcButton: .negative, fgColor: .foregroundRightButtons, bgColor: .buttonBackground)
    }
}
