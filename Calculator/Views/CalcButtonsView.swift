//
//  CalcButtonsView.swift
//  Calculator
//
//  Created by Weerawut Chaiyasomboon on 29/2/2567 BE.
//

import SwiftUI

struct CalcButtonModel: Identifiable{
    let id = UUID()
    let calcButton: CalcButton
    var color: Color = .foregroundDigits
}

struct RowOfCalcButtonsModel: Identifiable{
    let id = UUID()
    let row: [CalcButtonModel]
}

struct CalcButtonsView: View {
    @Binding var currentComputation: String
    @Binding var mainResult: String
    
    let buttonData: [RowOfCalcButtonsModel] = [
    RowOfCalcButtonsModel(row: [
        CalcButtonModel(
            calcButton: .clear,
            color: .foregroundTopButtons),
        CalcButtonModel(
            calcButton: .negative,
            color: .foregroundTopButtons),
        CalcButtonModel(
            calcButton: .percent,
            color: .foregroundTopButtons),
        CalcButtonModel(
            calcButton: .divide,
            color: .foregroundRightButtons)
    ]),
    RowOfCalcButtonsModel(row: [
        CalcButtonModel(calcButton: .seven),
        CalcButtonModel(calcButton: .eight),
        CalcButtonModel(calcButton: .nine),
        CalcButtonModel(calcButton: .multiply,
                        color: .foregroundRightButtons
                       )
    ]),
    RowOfCalcButtonsModel(row: [
        CalcButtonModel(calcButton: .four),
        CalcButtonModel(calcButton: .five),
        CalcButtonModel(calcButton: .six),
        CalcButtonModel(calcButton: .subtract,
                        color: .foregroundRightButtons
                       )
    ]),
    RowOfCalcButtonsModel(row: [
        CalcButtonModel(calcButton: .one),
        CalcButtonModel(calcButton: .two),
        CalcButtonModel(calcButton: .three),
        CalcButtonModel(calcButton: .add,
                        color: .foregroundRightButtons
                       )
    ]),
    RowOfCalcButtonsModel(row: [
        CalcButtonModel(calcButton: .undo),
        CalcButtonModel(calcButton: .zero),
        CalcButtonModel(calcButton: .decimal),
        CalcButtonModel(calcButton: .equal,
                        color: .foregroundRightButtons
                       )
    ])
    ]
    
    var body: some View {
        Grid{
            ForEach(buttonData) { rowOfCalcButtonsModel in
                GridRow{
                    ForEach(rowOfCalcButtonsModel.row) { calcButtonModel in
                        
                        Button(action: {
                            buttonPressed(calcButton: calcButtonModel.calcButton)
                        }, label: {
                            ButtonView(calcButton: calcButtonModel.calcButton, fgColor: calcButtonModel.color, bgColor: .buttonBackground)
                        })
                        
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.secondaryBackground)
        )
    }
    
    func buttonPressed(calcButton: CalcButton){
        switch calcButton{
        case .clear:
            currentComputation = ""
            mainResult = "0"
        case .equal, .negative:
            if !currentComputation.isEmpty{
                if !lastCharIsAnOperator(str: currentComputation){
                    let sign = calcButton == .negative ? -1.0 : 1.0
                    mainResult = formatResult(val: sign * calculateResult())
                    if calcButton == .negative{
                        currentComputation = mainResult
                    }
                }
            }
        case .decimal:
            if let lastOccurenceOfDecimal = currentComputation.lastIndex(of: "."){
                if lastCharIsDigit(str: currentComputation){
                    let startIndex = currentComputation.index(lastOccurenceOfDecimal, offsetBy: 1)
                    let endIndex = currentComputation.endIndex
                    let range = startIndex..<endIndex
                    let rightSubstring = String(currentComputation[range])
                    
                    //Only have "." must not add another "."
                    //23.37+108 Good -> can add "."
                    //123.45 Bad -> remain 123.45
                    if Int(rightSubstring) == nil && !rightSubstring.isEmpty{
                        currentComputation += "."
                    }
                }
            }
            else{
                if currentComputation.isEmpty{
                    currentComputation += "0."
                }else if lastCharIsDigit(str: currentComputation){
                    currentComputation += "."
                }
            }
            
        case .percent:
            if lastCharIsDigit(str: currentComputation){
                appendToCurrentComputation(calcButton: calcButton)
            }
        case .undo:
            currentComputation = String(currentComputation.dropLast())
        case .add, .subtract, .divide, .multiply:
            if lastCharIsDigitOrPercent(str: currentComputation){
                appendToCurrentComputation(calcButton: calcButton)
            }
        default:
            //case of digits
            appendToCurrentComputation(calcButton: calcButton)
        }
    }
    
    func appendToCurrentComputation(calcButton: CalcButton){
        currentComputation += calcButton.rawValue
    }
    
    func calculateResult() -> Double{
        let visibleWorkings: String = currentComputation
        var workings = visibleWorkings.replacingOccurrences(of: "%", with: "*0.01")
        workings = workings.replacingOccurrences(of: multiplySymbol, with: "*")
        workings = workings.replacingOccurrences(of: divisionSymbol, with: "/")
        
        //in case we have 35. this will to be 35.0
        if getLastChar(str: visibleWorkings) == "."{
            workings += "0"
        }
        
        //Actual computation
        let expr = NSExpression(format: workings)
        let exprValue = expr.expressionValue(with: nil, context: nil) as! Double
        
        return exprValue
    }
}

#Preview {
    CalcButtonsView(currentComputation: .constant("5+1"), mainResult: .constant("6"))
}
