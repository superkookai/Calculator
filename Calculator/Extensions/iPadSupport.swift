//
//  iPadSupport.swift
//  Calculator
//
//  Created by Weerawut Chaiyasomboon on 1/3/2567 BE.
//

import SwiftUI

extension UIDevice{
    static var isIPad: Bool{
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool{
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
