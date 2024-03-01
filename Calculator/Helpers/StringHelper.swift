//
//  StringHelper.swift
//  Calculator
//
//  Created by Weerawut Chaiyasomboon on 1/3/2567 BE.
//

import Foundation

///Return last character if exist, otherwise return empty string
func getLastChar(str: String) -> String{
    return str.isEmpty ? "" : String(str.last!)
}

func lastCharacterIsEqaulTo(str: String, char: String) -> Bool{
    let last = getLastChar(str: str)
    return last == char
}

func formatResult(val: Double) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 16
    
    let result = numberFormatter.string(from: NSNumber(value: val))
    
    return result ?? "0"
}

func lastCharIsDigit(str: String) -> Bool{
    return "0123456789".contains(getLastChar(str: str))
}

func lastCharIsDigitOrPercent(str: String) -> Bool{
    return "0123456789%".contains(getLastChar(str: str))
}

func lastCharIsAnOperator(str: String) -> Bool{
    return operators.contains(getLastChar(str: str))
}
