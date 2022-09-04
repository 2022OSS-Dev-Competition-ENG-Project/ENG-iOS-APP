//
//  PostingListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct PostListView: View {
    
    @StateObject var VM = MyContentListViewModel()
    
    var body: some View {
        List(VM.contents) { content in
            NavigationLink {
                PostDetailView(contentNum: content.id)
            } label: {
                ReportListDetailRowView(contentTitle: content.contentTitle, contentText: content.contentText)
            }
        }
        .navigationTitle("내가 쓴 글")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostListView()
        }
    }
}
