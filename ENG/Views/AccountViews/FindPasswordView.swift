//
//  FindPasswordView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/22.
//

import SwiftUI

// MARK: - MainViewStruct
struct FindPasswordView: View {
    
    // NavigationView Dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// 비밀번호 찾기 뷰 모델
    @StateObject var VM = ResetPassWordViewModel()
    /// 이메일 정보를 입력 받는 텍스트 필드
    @State var emailTextField: String = ""
    /// 이름 정보를 입력 받는 텍스트 필드
    @State var nameTextField: String = ""
    
    var body: some View {
        VStack {
            HeaderView
            
            InputView
        }
        // Navigation View 관련 설정
        .navigationTitle("비밀번호 찾기")
        .navigationBarTitleDisplayMode(.inline)
        // 비밀번호 초기화 성공 시 alert
        .alert("비밀번호 초기화 성공", isPresented: $VM.isAvaliable) {
            Button("확인", action: { self.presentationMode.wrappedValue.dismiss() })
        } message: {
            Text("입력하신 \(emailTextField)로 초기화된 비밀번호를 전송하였습니다.")
        }
        // 비밀번호 초기화 실패 시 alert
        .alert("입력 오류", isPresented: $VM.isError) {
            Button("확인", action: { })
        } message: {
            Text("입력하신 정보가 없거나, 일치하지 않습니다.\n 다시 한 번 확인해주세요.")
        }
    }
}

// MARK: - Components
extension FindPasswordView {
    /// 비밀번호 찾기 뷰 헤더
    private var HeaderView: some View {
        VStack {
            Image("Logo")
            Text("비밀번호를 잊으셨나요?")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .foregroundColor(.theme.accent)
                .padding(.bottom, 33)
        }
    }
    
    /// 비밀번호 입력에 필요한 정보를 입력하는 Input View
    private var InputView: some View {
        VStack {
            ZStack {
                TextField("이메일(아이디)을 입력하세요.", text: $emailTextField)
                    .customTextField(padding: 13)
                    .frame(width: 288, alignment: .center)
                    .font(.custom(Font.theme.mainFont, size: 15))
                HStack {
                    Spacer()

                    Image(systemName: "mail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.trailing, 10)
                    

                }
                .frame(width: 288)
            }
            
            ZStack {
                TextField("이름을 입력하세요.", text: $nameTextField)
                    .customTextField(padding: 13)
                    .frame(width: 288, alignment: .center)
                    .font(.custom(Font.theme.mainFont, size: 15))
                HStack {
                    Spacer()

                    Image(systemName: "greetingcard")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.trailing, 10)
                }
                .frame(width: 288)
            }
            
            Button {
                findPW()
            } label: {
                Text("비밀번호 찾기")
                    .frame(width: 288, height: 40, alignment: .center)
                    .background(Color.theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .padding(.top, 30)

        }
    }

    
}

// MARK: - Functions
extension FindPasswordView {
    private func findPW() {
        VM.doResetPW(data: ResetPWRequestModel(userEmail: emailTextField, userName: nameTextField))
        print("비밀번호 찾기 완료")
    }
}

// MARK: - Preview
struct FindPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FindPasswordView()
        }
    }
}
