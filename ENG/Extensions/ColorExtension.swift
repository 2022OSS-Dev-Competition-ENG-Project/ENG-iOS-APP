//
//  ColorExtension.swift
//  ENG
//
//  Created by 정승균 on 2022/08/10.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let red = Color("Red")
    let secondary = Color("SecondaryColor")
    let sub = Color("SubColor")
}
