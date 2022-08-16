//
//  SignUpView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

struct SignUpView: View {
    
    @State var eMailTextField: String = ""
    @State var passWordTextField: String = ""
    @State var PWAgainTextField: String = ""
    @State var eMailCodeTextField: String = ""
    
    var body: some View {
        VStack {
            Image("Logo")
            Text("새로운 계정을 생성합니다.")
                .font(.custom("Apple SD Gothic Neo Bold", size: 15))
                .foregroundColor(.theme.accent)
                .padding(.bottom, 33)
            Text("계정 정보 입력")
                .font(.custom("Apple SD Gothic Neo Bold", size: 15))
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
                .font(.custom("Apple SD Gothic Neo Bold", size: 15))
                .frame(width: 290, alignment: .leading)
                .padding(.bottom, 12)
            
            TextField("인증 코드 입력", text: $eMailCodeTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 70)
            
            Button {
                
            } label: {
                Text("회원 가입")
                    .frame(width: 288, height: 40, alignment: .center)
                    .background(Color.theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }

            Spacer()
            
        }
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func signUp() {
        print("회원가입 완료")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
        
    }
}
