//
//  LoginView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

struct LoginView: View {
    
    @State var idTextField: String = ""
    @State var pwdTextField: String = ""
    @State var isSignUpTabbed: Bool = false
    
    var body: some View {
        VStack {
            
            InputView
            
            Spacer()
            
            SignUpButtonView
                .padding(.bottom, 15)

        }
        .navigationTitle("로그인")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
        
    }
}

extension LoginView {
    private var InputView: some View {
        VStack(spacing: 16) {
            ZStack {
                TextField("아이디를 입력하세요.", text: $idTextField)
                    .customTextField(padding: 13)
                    .frame(width: 288, alignment: .center)
                    .font(.custom("Apple SD Gothic Neo", size: 15))
                HStack {
                    Spacer()

                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .trailing)
                        .padding(.trailing, 10)

                }
                .frame(width: 288)

            }
            
            ZStack {
                SecureField("비밀번호를 입력하세요.", text: $pwdTextField)
                    .customTextField(padding: 13)
                    .frame(width: 288, alignment: .center)
                    .font(.custom("Apple SD Gothic Neo", size: 15))
                HStack {
                    Spacer()

                    Image(systemName: "key.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .trailing)
                        .padding(.trailing)
                }
                .frame(width: 288)

            }
            
            Button {
                Login()
            } label: {
                Text("로그인")
                    .frame(width: 288, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.theme.accent)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            
            NavigationLink("계정 정보를 잊으셨나요?") {
                FindAccountView()
            }
            .foregroundColor(.theme.sub)
            .font(.custom("Apple SD Gothic Neo Bold", size: 12))
            .frame(width: 288, alignment: .leading)

        }
        .frame(height: UIScreen.main.bounds.height * 0.7)
    }
    private var SignUpButtonView: some View {
        HStack {
            Text("아직 계정이 없으신가요?")
                .foregroundColor(.theme.secondary)
            Text("SignUp")
                .foregroundColor(.theme.sub)
            NavigationLink("", destination: SignUpView(), isActive: $isSignUpTabbed)
        }
        .font(.custom("Apple SD Gothic Neo Bold", size: 12))
        .onTapGesture {
            isSignUpTabbed.toggle()
        }
    }
    
    private func Login() {
        print("로그인 완")
    }
}
