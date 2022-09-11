//
//  PosterDetailView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

// MARK: - MainViewStruct
struct PosterDetailView: View {
    
    let contentNum: Int
    
    @StateObject var VM = PosterDetailViewModel()
    /// 댓글 작성 텍스트 필드
    @State var commentTextField: String = ""
    /// 댓글 작성 버튼 동작 프로퍼티
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
        // 게시물 삭제 버튼
        .navigationBarItems(trailing: Button("삭제", action: {
            guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
            VM.deleteContent(userUUID: UUID, contentId: self.contentNum)
        })
            .hideToBool(VM.content.writerUuid != UserDefaults.standard.string(forKey: "loginToken")!)
            .foregroundColor(.theme.red)
        )
        // 삭제 성공 시 alert
        .alert("삭제 성공", isPresented: $VM.isDelete, actions: {
            Button("확인", action: { self.presentationMode.wrappedValue.dismiss() })
        })
        // 댓글 작성
        .onChange(of: self.isSend, perform: { newValue in
            writeComment()
        })
        .onAppear {
            getPosterInfo()
        }
    }
}

// MARK: - Components
extension PosterDetailView {
    /// 게시물 정보 뷰
    private var ContentView: some View {
        VStack(alignment: .leading) {
            Text(VM.content.contentTitle)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            Text(VM.content.contentText)
        }
        
    }
    
    /// 작성자 정보 뷰
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
                        VM.likeContent(data: PosterLikeModel(userUuid: userUUID, contentNum: self.contentNum), contentNum: self.contentNum)
                 }
                Text(VM.likeCount)
                    .font(.custom(Font.theme.mainFontBold, size: 20))
            }
        }
    }
    
    /// 댓글 리스트 뷰
    private var CommentListView: some View {
        VStack {
            ForEach(VM.comments) { comment in
                CommentRowView(commentNum: comment.id, nickName: comment.userNickName, commentText: comment.commentText, commentDate: comment.commentViewDate, userUUID: comment.userUuid)
                    .environmentObject(VM)
            }
        }
    }
}

// MARK: - Functions
extension PosterDetailView {
    /// 게시물 내용 불러오기
    func getPosterInfo() {
        guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        VM.getContent(userUUID: UUID, contentId: self.contentNum)
        VM.getComment(contentId: self.contentNum)
        VM.getLike(contentId: self.contentNum)
    }
    
    /// 댓글 작성 메서드
    func writeComment() {
        guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        VM.createComment(contentId: self.contentNum, data: CommentRegisterModel(commentText: self.commentTextField, contentNum: String(self.contentNum), userUuid: UUID))
        self.commentTextField = ""
    }
}

// MARK: - Preview
struct PosterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PosterDetailView(contentNum: 57)
        }
    }
}
