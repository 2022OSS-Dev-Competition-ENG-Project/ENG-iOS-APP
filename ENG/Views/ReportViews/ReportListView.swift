//
//  ReportListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

// MARK: - MainViewStruct
struct ReportListView: View {
    
    @StateObject var VM = ReportListViewModel()
    
    var body: some View {
        List(VM.reports) { row in
            ReportListDetailRowView(contentTitle: row.reportTitle, reportStatus: row.reportStatus)
        }
        .navigationTitle("신고 내역")
        .navigationBarTitleDisplayMode(.inline)

    }
}

// MARK: - Preview
struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportListView()
        }
    }
}
