//
//  PostingListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct PostingListView: View {
    var body: some View {
            List(0..<100) { row in
                ReportListDetailRowView()
            }
            .navigationTitle("내가 쓴 글")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostingListView_Previews: PreviewProvider {
    static var previews: some View {
        PostingListView()
    }
}
