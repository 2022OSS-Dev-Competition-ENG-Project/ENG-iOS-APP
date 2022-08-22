//
//  FindPasswordView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/22.
//

import SwiftUI

struct FindPasswordView: View {
    
    @State var emailTextField: String = ""
    @State var nameTextField: String = ""
    
    @State var isAvaliable: Bool = false
    @State var isError: Bool = false
    
    var body: some View {
        VStack {
            HeaderView
            
            InputView
        }
        .navigationTitle("비밀번호 찾기")
        .navigationBarTitleDisplayMode(.inline)
        .alert("비밀번호 초기화 성공", isPresented: $isAvaliable) {
            Button("확인", action: { })
        } message: {
            Text("입력하신 \(emailTextField)로 초기화된 비밀번호를 전송하였습니다.")
        }
        .alert("입력 오류", isPresented: $isError) {
            Button("확인", action: { })
        } message: {
            Text("입력하신 정보가 없거나, 일치하지 않습니다.\n 다시 한 번 확인해주세요.")
        }
    }
}

struct FindPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FindPasswordView()
        }
    }
}

extension FindPasswordView {
    private var HeaderView: some View {
        VStack {
            Image("Logo")
            Text("비밀번호를 잊으셨나요?")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .foregroundColor(.theme.accent)
                .padding(.bottom, 33)
        }
    }
    
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
                SecureField("이름을 입력하세요.", text: $nameTextField)
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
    
    private func findPW() {
        isAvaliable = true
//        isError = true
        print("비밀번호 찾기 완료")
    }
    
}
