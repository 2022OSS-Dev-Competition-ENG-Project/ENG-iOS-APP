//
//  FacilityPosterListView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

// MARK: - MainViewStruct
struct FacilityPosterListView: View {
    
    let facilityId: String
    
    @StateObject var VM = FacilityPosterListViewModel()
    
    var body: some View {
        List(VM.posters) { row in
            NavigationLink(destination: PosterDetailView(contentNum: row.id)) {
                ReportListDetailRowView(contentTitle: row.contentTitle, contentText: row.contentText)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("안전소통게시판")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: NavigationLink("글쓰기", destination: PostingFieldView(facilityId: self.facilityId))
            .foregroundColor(.theme.red)
        )
        .onAppear() {
            VM.getPosters(faciliityId: self.facilityId)
            UIScrollView.appearance().isPagingEnabled = false
        }

    }
}

// MARK: - Preview
struct FacilityPosterListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FacilityPosterListView(facilityId: "247f9839-53a4-426c-994d-878f1c05d47b")
        }
    }
}
