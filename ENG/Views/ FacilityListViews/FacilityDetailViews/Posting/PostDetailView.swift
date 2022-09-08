//
//  PostDetailView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

struct PostDetailView: View {
    
    let contentNum: Int
    
    @StateObject var VM = ContentDetailViewModel()
    @State var commentTextField: String = ""
    @State var isSend: Bool = false
    
    // NavigationView Dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                        Section(footer: CommentTextfieldView(commentTextField: $commentTextField, isSend: $isSend)) {
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
        .navigationTitle(VM.content.contentTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("삭제", action: {
            guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
            VM.deleteContent(userUUID: UUID, contentId: self.contentNum)
        })
            .hideToBool(VM.content.writerUuid != UserDefaults.standard.string(forKey: "loginToken")!)
            .foregroundColor(.theme.red)
        )
        .alert("삭제 성공", isPresented: $VM.isDelete, actions: {
            Button("확인", action: { self.presentationMode.wrappedValue.dismiss() })
        })
        .onChange(of: self.isSend, perform: { newValue in
            guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
            VM.createComment(contentId: self.contentNum, data: CommentRegisterModel(commentText: self.commentTextField, contentNum: String(self.contentNum), userUuid: UUID))
            self.commentTextField = ""
        })
        .onAppear {
            guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
            VM.getContent(userUUID: UUID, contentId: self.contentNum)
            VM.getComment(contentId: self.contentNum)
            VM.getLike(contentId: self.contentNum)
        }
    }
}


struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(contentNum: 57)
        }
    }
}

extension PostDetailView {
    private var ContentView: some View {
        VStack(alignment: .leading) {
            Text(VM.content.contentTitle)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            Text(VM.content.contentText)
        }
        
    }
    
    private var authorInfoView: some View {
        HStack(alignment: .center, spacing: 15) {
            AsyncImage(url: URL(string: VM.content.writerViewImage)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60, alignment: .center)
                    .overlay(Circle()
                        .stroke(Color.theme.secondary, lineWidth: 1)
                    )
                
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48, alignment: .center)
            }
            
            VStack(alignment: .leading) {
                Text(VM.content.writerNickname)
                    .font(.custom(Font.theme.mainFontBold, size: 24))
                Text(VM.content.contentViewDate)
                    .font(.custom(Font.theme.mainFont, size: 16))
                    .foregroundColor(.theme.secondary)
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                Image(systemName: VM.content.userLike ? "star.fill" : "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(.theme.red)
                    .onTapGesture {
                        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
                        VM.likeContent(data: ContentLikeModel(userUuid: userUUID, contentNum: self.contentNum), contentNum: self.contentNum)
                 }
                Text(VM.likeCount)
                    .font(.custom(Font.theme.mainFontBold, size: 20))
            }
            
//            VStack(spacing: 0) {
//                Image(systemName: "hand.thumbsdown.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 25, height: 25, alignment: .center)
//                    .foregroundColor(Color(hex: "3282B8"))
//                Text("3")
//                    .font(.custom(Font.theme.mainFontBold, size: 20))
//            }
        }
    }
    
    private var CommentListView: some View {
        VStack {
            ForEach(VM.comments) { comment in
                CommentRowView(commentNum: comment.id, nickName: comment.userNickName, commentText: comment.commentText, commentDate: comment.commentViewDate, userUUID: comment.userUuid)
                    .environmentObject(VM)
            }
        }
    }
}
