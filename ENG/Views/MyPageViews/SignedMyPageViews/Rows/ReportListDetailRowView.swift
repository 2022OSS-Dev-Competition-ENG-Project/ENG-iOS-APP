//
//  ReportListDetailRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct ReportListDetailRowView: View {
    
    let contentTitle: String
    let contentText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contentTitle)
                .font(.custom(Font.theme.mainFontBold, size: 13))
            Text(contentText)
                .font(.custom(Font.theme.mainFont, size: 10))
                .foregroundColor(Color.theme.secondary)
                .lineLimit(1)
                .padding(.trailing)
        }
        .frame(width: 329, height: 58, alignment: .leading)
        .padding(.horizontal)
    }
}

struct ReportListDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReportListDetailRowView(contentTitle: "제목", contentText: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용")
            .previewLayout(.sizeThatFits)
    }
}
