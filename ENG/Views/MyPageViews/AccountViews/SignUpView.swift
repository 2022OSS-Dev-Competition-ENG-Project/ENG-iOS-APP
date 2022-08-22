//
//  SignUpView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

struct SignUpView: View {
    
    // 계정 정보 TextField
    @State var eMailTextField: String = ""
    @State var passWordTextField: String = ""
    @State var PWAgainTextField: String = ""
    @State var eMailCodeTextField: String = ""
    
    // 회원 정보 TextField
    @State var nameTextField: String = ""
    @State var nicknameTextField: String = ""
    @State var phonenumberTextField: String = ""
    @State var birthTextField: String = ""
    
    // 인증 여부에 따른 UI 제어
    @State var isAuthenticated: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HeaderView
                
                AccountInfoInputView
                
                if isAuthenticated {
                    UserInfoInputView
                    
                    Button {
                        signUp()
                    } label: {
                        Text("회원 가입")
                            .frame(width: 288, height: 40, alignment: .center)
                            .background(Color.theme.accent)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    }
                }
                else {
                    Button {
                        emailAuthenticate()
                    } label: {
                        Text("이메일 인증")
                            .frame(width: 288, height: 40, alignment: .center)
                            .background(Color.theme.accent)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    }
                }
                
                
                

                Spacer()
                
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    private func signUp() {
        print("회원가입 완료")
    }
    
    private func emailAuthenticate() {
        print("이메일 인증 완료")
        isAuthenticated = true
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
        
    }
}

extension SignUpView {
    private var HeaderView: some View {
        VStack {
            Image("Logo")
            Text("새로운 계정을 생성합니다.")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .foregroundColor(.theme.accent)
                .padding(.bottom, 33)
        }
    }
    
    private var AccountInfoInputView: some View {
        VStack {
            Text("계정 정보 입력")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .frame(width: 290, alignment: .leading)
                .padding(.bottom, 12)
            
            TextField("이메일을 입력하세요.", text: $eMailTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
            
            TextField("비밀번호를 입력하세요.", text: $passWordTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
            
            TextField("비밀번호를 다시 입력하세요.", text: $PWAgainTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 23)
            
            Text("이메일 인증")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .frame(width: 290, alignment: .leading)
                .padding(.bottom, 12)
                
            
            TextField("인증 코드 입력", text: $eMailCodeTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 23)
                .disabled(isAuthenticated ? true : false)
                .foregroundColor(isAuthenticated ? Color.theme.secondary : Color.black)
        }
    }
    
    private var UserInfoInputView: some View {
        VStack {
            Text("회원 정보 입력")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .frame(width: 290, alignment: .leading)
                .padding(.bottom, 12)
            
            TextField("이름을 입력하세요.", text: $nameTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
            
            TextField("닉네임을 입력하세요.", text: $nicknameTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
            
            TextField("휴대폰 번호를 입력하세요.", text: $phonenumberTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
            
            TextField("생일을 입력하세요.", text: $phonenumberTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 48)
        }
    }
}
