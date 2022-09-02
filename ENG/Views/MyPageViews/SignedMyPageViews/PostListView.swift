//
//  PostingListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct PostListView: View {
    var body: some View {
            List(0..<100) { row in
                ReportListDetailRowView(contentTitle: "dd", contentText: "ff")
            }
            .navigationTitle("내가 쓴 글")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
