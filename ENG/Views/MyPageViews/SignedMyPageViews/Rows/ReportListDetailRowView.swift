//
//  ReportListDetailRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct ReportListDetailRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("글 제목")
                .font(.custom(Font.theme.mainFontBold, size: 13))
            Text("글 미리보기글 미리보기글 미리보기글 미리보기글 미리보기글 미리보기글 미리보기글 미리보기")
                .font(.custom(Font.theme.mainFont, size: 10))
                .foregroundColor(Color.theme.secondary)
                .lineLimit(1)
        }
        .frame(width: 329, height: 58, alignment: .center)
    }
}

struct ReportListDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReportListDetailRowView()
            .previewLayout(.sizeThatFits)
    }
}
