//
//  ColorExtension.swift
//  ENG
//
//  Created by 정승균 on 2022/08/10.
//

import Foundation
import SwiftUI

extension Color {
    /// Assets에 추가한 색상 사용하기 편하도록 extenstion 구현
    /// ```
    /// Ex)
    /// Text("Red Color")
    ///     .foregroundColor(Color.theme.red)
    /// ```
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let red = Color("Red")
    let secondary = Color("SecondaryColor")
    let sub = Color("SubColor")
}
