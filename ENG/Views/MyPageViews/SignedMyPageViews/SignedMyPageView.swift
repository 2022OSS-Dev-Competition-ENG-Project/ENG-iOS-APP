//
//  SignedMyPageView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct SignedMyPageView: View {
    
    @StateObject var loginVM = LoginViewModel.shared
    @StateObject var VM = MyPageViewModel()
    
    @State var showImagePicker: Bool = false
    @State var uploadImage: UIImage = UIImage()
    @State var refreshMe: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                BasicInformation
                    .padding(.vertical, 38)
                
                ReportList
                    .padding(.bottom, 20)
                
                MyPostingList
                
                Spacer()
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button("로그아웃", action: logOut)
                        .foregroundColor(Color.theme.red)
            )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.uploadImage = image
                VM.registerUserProfileImage(paramName: "images", fileName: "profile.png", image: uploadImage)
            }
        }
        .alert("전송 성공!", isPresented: $VM.isUploadSucess) {
            Button("확인") {
                
            }
        }
    }
    
    private func logOut() {
        loginVM.doLogOut()
    }
}

struct SignedMyPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignedMyPageView()
        }
    }
}

extension SignedMyPageView {
    private var BasicInformation: some View {
        
        HStack(spacing: 30) {
            AsyncImage(url: URL(string: VM.userInfo.userImg)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 115, height: 115, alignment: .center)
                    .overlay(Circle()
                        .stroke(Color.theme.secondary, lineWidth: 1)
                    )
                
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 115, height: 115, alignment: .center)
                    .overlay(Circle()
                        .stroke(Color.theme.secondary, lineWidth: 1)
                    )
            }
            .tint(refreshMe ? .black : .black)
            .onTapGesture {
                showImagePicker.toggle()
            }
            
            
            VStack(alignment: .leading) {
                Text(VM.userInfo.userNickname)
                    .font(.custom(Font.theme.mainFontBold, size: 24))
                Text(VM.userInfo.userEmail)
                    .font(.custom(Font.theme.mainFont, size: 16))
                    .foregroundColor(.theme.secondary)
                
                HStack {
                    Text("가입일")
                    Text(VM.userInfo.userJoinViewDate)
                }
                .font(.custom(Font.theme.mainFont, size: 16))
                .foregroundColor(.theme.secondary)

            }
        }

    }
    
    private var ReportList: some View {
        VStack {
            HStack {
                Text("신고 내역")
                    .font(.custom(Font.theme.mainFontBold, size: 20))
                
                Spacer()
                
                NavigationLink {
                    ReportListView()
                } label: {
                    Text("더보기")
                        .font(.custom(Font.theme.mainFont, size: 14))
                        .foregroundColor(.theme.accent)
                }

            }
            .frame(width: 349, alignment: .center)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.theme.secondary, lineWidth: 1)
                    .padding(.horizontal)
                    .frame(height: 153)
                VStack {
                    ForEach(VM.mainMyReports) { report in
                        ReportListRowView(reportNumber: report.id, reportTitle: report.reportTitle, reportStatus: report.reportStatus)
                    }
                }
            }
        }
    }
    
    private var MyPostingList: some View {
        VStack {
            HStack {
                Text("내가 쓴 글")
                    .font(.custom(Font.theme.mainFontBold, size: 20))
                
                Spacer()
                
                NavigationLink {
                    PostListView()
                } label: {
                    Text("더보기")
                        .font(.custom(Font.theme.mainFont, size: 14))
                        .foregroundColor(.theme.accent)
                }
            }
            .frame(width: 349, alignment: .center)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.theme.secondary, lineWidth: 1)
                    .padding(.horizontal)
                    .frame(height: 153)
                VStack {
                    ForEach(VM.mainMyContents) { content in
                        NavigationLink {
                            PostDetailView(contentNum: content.id)
                        } label: {
                            PostingListRowView(postingNumber: content.id, postingTitle: content.contentTitle)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}
