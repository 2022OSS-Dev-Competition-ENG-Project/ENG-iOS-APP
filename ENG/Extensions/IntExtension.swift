//
//  IntExtension.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import Foundation
import SwiftUI

extension Int {
    
    
    /// 정수를 4자리 String으로 변환
    /// ```
    /// Convert 1 -> "0001"
    /// Convert 49 -> "0049"
    /// Convert 34124 -> "34124"
    /// ```
    private func asNumber4String() -> String {
        return String(format: "%04d", self)
    }
    
    /// append "#" infront of Number
    /// ```
    /// Convert 1 -> "#0001"
    /// Convert 34124 -> "#34124"
    /// ```
    func asListNumberString() -> String {
        return "#" + asNumber4String()
    }
}

