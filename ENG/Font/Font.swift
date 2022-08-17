//
//  Font.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import Foundation
import SwiftUI

extension Font {
    /// 프로젝트 전용 폰트 구조체
    /// ```
    /// Ex)
    /// Text("Red Color")
    ///     .font(.custom(Font.theme.mainFont, size: 14)
    /// ```
    static let theme = FontTheme()
}

struct FontTheme {
    let mainFont = "Apple SD Gothic Neo"
    let mainFontBold = "Apple SD Gothic Neo Bold"
}
