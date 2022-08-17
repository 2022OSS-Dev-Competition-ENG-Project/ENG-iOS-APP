//
//  ReportListRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct ReportListRowView: View {
    
    @State var reportNumber: Int = 1
    var isComplete: Bool = false
    
    var body: some View {
        HStack {
            Text(reportNumber.asListNumberString())
            Text("글 제목 1")
            Spacer()
            Text(isComplete ? "완료" : "처리 중")
                .foregroundColor(isComplete ? .theme.green : .theme.orange)
        }
        .font(.custom(Font.theme.mainFont, size: 14))
        .frame(width: 327, height: 20, alignment: .center)
        
    }
}

struct ReportListRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReportListRowView(isComplete: true)
                .previewLayout(.sizeThatFits)
            
            ReportListRowView(isComplete: false)
                .previewLayout(.sizeThatFits)
        }

    }
}
