//
//  ReportListRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

// MARK: - MainViewStruct
/// - Note: Related with `MyProfileView`
struct ReportListRowView: View {
    
    @State var reportNumber: Int = 1
    var reportTitle: String
    var reportStatus: Int
    
    var body: some View {
        HStack {
            Text(reportNumber.asListNumberString())
            Text(reportTitle)
            Spacer()
            Text(reportStatus == 1 ? "처리" : reportStatus == 2 ? "반려" : "미처리")
                .foregroundColor(reportStatus == 1 ? .theme.green : reportStatus == 2 ? .theme.red : .theme.orange)
        }
        .font(.custom(Font.theme.mainFont, size: 14))
        .frame(width: 327, height: 20, alignment: .center)
        
    }
}

// MARK: - Preview
struct ReportListRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReportListRowView(reportTitle: "신고함", reportStatus: 1)
                .previewLayout(.sizeThatFits)
            
            ReportListRowView(reportTitle: "신고 또 함", reportStatus: 2)
                .previewLayout(.sizeThatFits)
        }

    }
}
