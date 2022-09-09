//
//  FindIDView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/22.
//

import SwiftUI

struct FindIDView: View {
    
    // NavigationView Dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var VM = FindIdViewModel()
    
    @State var nameTextField: String = ""
    @State var phoneNumberTextField: String = ""

    
    var body: some View {
        VStack {
            HeaderView
            
            InputView
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle("ID 찾기")
        .navigationBarTitleDisplayMode(.inline)
        .alert("아이디 찾기", isPresented: $VM.isFoundId) {
            Button("확인", action: { self.presentationMode.wrappedValue.dismiss() })
        } message: {
            Text("회원님의 아이디는 \(VM.userEmail)입니다.")
        }
        .alert("아이디 찾기 실패", isPresented: $VM.isCanNotFindId) {
            Button("확인", action: {  })
        } message: {
            Text("아이디 찾기에 실패하였습니다. 다시 한 번 확인해주세요.")
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct FindIDView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FindIDView()
        }
    }
}

extension FindIDView {
    private var HeaderView: some View {
        VStack {
            Image("Logo")
            Text("아이디를 잊어버리셨나요?")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .foregroundColor(.theme.accent)
                .padding(.bottom, 33)
        }
    }
    
    private var InputView: some View {
        VStack {
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
            
            ZStack {
                TextField("전화번호를 입력하세요. ('-' 제외)", text: $phoneNumberTextField)
                    .customTextField(padding: 13)
                    .frame(width: 288, alignment: .center)
                    .font(.custom(Font.theme.mainFont, size: 15))
                    .keyboardType(.numberPad)
                HStack {
                    Spacer()

                    Image(systemName: "candybarphone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.trailing, 10)
                }
                .frame(width: 288)
            }
            
            Button {
                findID()
            } label: {
                Text("아이디 찾기")
                    .frame(width: 288, height: 40, alignment: .center)
                    .background(Color.theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .padding(.top, 30)

        }
    }
    
    private func findID() {
        print("아이디 찾기 시도")
        VM.doFindId(data: FindIdModel(userName: nameTextField, userPhoneNumber: phoneNumberTextField))
    }
    
}
