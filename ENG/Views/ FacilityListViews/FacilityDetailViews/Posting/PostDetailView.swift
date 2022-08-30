//
//  PostDetailView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

struct PostDetailView: View {
    var body: some View {
        ZStack {
            Color(hex: "EBEBEB")

            ScrollView {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .padding(.horizontal, 16)
                    .padding(.top, 28)
                    .foregroundColor(Color.white)
                    .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionFooters]) {
                        Section(footer: CommentTextfieldView()) {
                            VStack(alignment: .leading) {
                                ContentView
                                    .padding(.top, 28)
                                    .padding(.bottom, 51)
                                
                                authorInfoView
                                    .padding(.bottom, 25)
                                
                                Divider()
                            }
                            .padding(.horizontal, 28)

                                CommentListView
                                    .listStyle(.plain)
                                    .padding(.horizontal, 28)
                                
                                Spacer()

                        }
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 28)
                }
            }
        }
        .navigationTitle("글 제목")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView()
        }
    }
}

extension PostDetailView {
    private var ContentView: some View {
        Text("이런이런 일이 있는데 어떻게 생각하세요?")
    }
    
    private var authorInfoView: some View {
        HStack(spacing: 15) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48, alignment: .center)
            
            VStack(alignment: .leading) {
                Text("작성자")
                    .font(.custom(Font.theme.mainFontBold, size: 24))
                Text("08/01 00:00")
                    .font(.custom(Font.theme.mainFont, size: 16))
                    .foregroundColor(.theme.secondary)
            }
            
            VStack(spacing: 0) {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(.theme.red)
                Text("24")
                    .font(.custom(Font.theme.mainFontBold, size: 20))
            }
            
            VStack(spacing: 0) {
                Image(systemName: "hand.thumbsdown.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(Color(hex: "3282B8"))
                Text("3")
                    .font(.custom(Font.theme.mainFontBold, size: 20))
            }
        }
    }
    
    private var CommentListView: some View {
        // 리스트 x
        VStack {
            ForEach(0..<100) { num in
                CommentRowView()
            }
        }
    }
}
