//
//  ViewExtension.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import Foundation
import SwiftUI

extension View {
    
    /// TextField의 디자인을 View와 ViewModifier를 활용한 함수로 구현
    ///
    ///  - parameters:
    ///     - color : TextField의 테두리 색
    ///     - padding :  내용과 테두리 사이의 간격
    ///     - lineWidth : TextField의 선 굵기
    ///     - cornerRadius : 테두리 둥글기 정도
    ///
    ///
    func customTextField(color: Color = Color.theme.secondary, padding: CGFloat = 3, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 8) -> some View {
        self.modifier(TextfieldModifier(color: color, padding: padding, lineWidth: lineWidth, cornerRadius: cornerRadius))
    }
}

struct TextfieldModifier: ViewModifier {
    let color: Color
    let padding: CGFloat
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: lineWidth)
            )
            .disableAutocorrection(true) // 자동 수정 방지 수정자
            .textInputAutocapitalization(.never)
            
    }
}
