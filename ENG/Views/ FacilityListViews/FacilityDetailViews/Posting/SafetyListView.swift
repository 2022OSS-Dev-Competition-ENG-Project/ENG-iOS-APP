//
//  ReportListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct SafetyListView: View {
    var body: some View {
        List(0..<100) { row in
            NavigationLink(destination: PostDetailView()) {
                ReportListDetailRowView()
            }
        }
        .navigationTitle("안전소통게시판")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: NavigationLink("글쓰기", destination: PostingView()))

    }
}

struct SafetyListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SafetyListView()
        }
    }
}
