//
//  ReportListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct SafetyListView: View {
    
    let facilityId: String
    
    @StateObject var VM = SaftyListViewModel()
    
    var body: some View {
        List(VM.posters) { row in
            NavigationLink(destination: PostDetailView()) {
                ReportListDetailRowView(contentTitle: row.contentTitle, contentText: row.contentText)
            }
        }
        .navigationTitle("안전소통게시판")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: NavigationLink("글쓰기", destination: PostingView()))
        .onAppear() {
            VM.getPosters(faciliityId: self.facilityId)
        }

    }
}

struct SafetyListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SafetyListView(facilityId: "247f9839-53a4-426c-994d-878f1c05d47b")
        }
    }
}
