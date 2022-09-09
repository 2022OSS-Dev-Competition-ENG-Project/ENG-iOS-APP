//
//  ReportListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct ReportListView: View {
    var body: some View {
        List(0..<100) { row in
            ReportListDetailRowView(contentTitle: "dd", contentText: "ff")
        }
        .navigationTitle("신고 내역")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportListView()
        }
    }
}
