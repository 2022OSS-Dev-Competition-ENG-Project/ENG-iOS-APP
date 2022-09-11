//
//  MyProfileView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

// MARK: - MainViewStruct
struct MyProfileView: View {
    
    @StateObject var loginVM = LoginViewModel.shared
    @StateObject var VM = MyProfileViewModel()
    
    /// ImagePicker를 제어할 프로퍼티
    @State var showImagePicker: Bool = false
    /// 업로드 할 이미지
    @State var uploadImage: UIImage = UIImage()
    
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
        // 갤러리에 접근할 수 있도록 하는 sheet
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.uploadImage = image
                VM.registerUserProfileImage(paramName: "images", fileName: "image.png", image: self.uploadImage)
            }
        }
        // 전송 성공 시 alert
        .alert("전송 성공!", isPresented: $VM.isUploadSucess) {
            Button("확인") {
                
            }
        }
    }
}

// MARK: - Components
extension MyProfileView {
    /// 기본 유저 정보를 담는 뷰
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
    
    /// 신고내역을 미리 볼 수 있도록 하는 뷰
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
    
    /// 내가 쓴 게시물 리스트를 미리 볼 수 있는 뷰
    private var MyPostingList: some View {
        VStack {
            HStack {
                Text("내가 쓴 글")
                    .font(.custom(Font.theme.mainFontBold, size: 20))
                
                Spacer()
                
                NavigationLink {
                    MyPosterListView()
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
                            PosterDetailView(contentNum: content.id)
                        } label: {
                            PosterListRowView(posterNumber: content.id, posterTitle: content.contentTitle)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Functions
extension MyProfileView {
    /// 로그아웃 함수
    private func logOut() {
        loginVM.doLogOut()
    }
}

// MARK: - Preview
struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyProfileView()
        }
    }
}
