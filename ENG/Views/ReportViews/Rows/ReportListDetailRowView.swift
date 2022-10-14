//
//  ReportListDetailRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct ReportListDetailRowView: View {
    
    let contentTitle: String
    let reportStatus: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text(contentTitle)
                    .font(.custom(Font.theme.mainFontBold, size: 13))
                Spacer()
                Text(reportStatus == 1 ? "처리" : reportStatus == 2 ? "반려" : "미처리")
                    .foregroundColor(reportStatus == 1 ? .theme.green : reportStatus == 2 ? .theme.red : .theme.orange)
            }
        }
        .frame(width: 329, height: 58, alignment: .leading)
        .padding(.horizontal)
    }
}

struct ReportListDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReportListDetailRowView(contentTitle: "제목", reportStatus: 1)
            .previewLayout(.sizeThatFits)
    }
}
