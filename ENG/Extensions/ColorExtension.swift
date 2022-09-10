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
    
    /// Hex 코드로 색 지정할 수 있도록 하는 생성자
    /// ```
    /// Color(hex: "EBEBEB")
    /// ```
    ///
    /// - Parameters: String 형태의 Hex Code
    ///
    /// - returns: Hex 코드에 맞는 Color
    init(hex: String) {
      let scanner = Scanner(string: hex)
      _ = scanner.scanString("#")
      
      var rgb: UInt64 = 0
      scanner.scanHexInt64(&rgb)
      
      let r = Double((rgb >> 16) & 0xFF) / 255.0
      let g = Double((rgb >>  8) & 0xFF) / 255.0
      let b = Double((rgb >>  0) & 0xFF) / 255.0
      self.init(red: r, green: g, blue: b)
    }
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let red = Color("Red")
    let secondary = Color("SecondaryColor")
    let sub = Color("SubColor")
    let orange = Color("Orange")
    let green = Color("Green")
    let lightBlue = Color("LightBlue")
}
