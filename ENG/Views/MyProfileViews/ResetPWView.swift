//
//  ResetPWView.swift
//  ENG
//
//  Created by 정승균 on 2022/10/15.
//

import SwiftUI

// MARK: MainViewStruct
struct ResetPWView: View {
    
    // NavigationView Dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// 비밀번호 재설정 뷰 모델
    @StateObject var VM = ResetPWViewModel()
    /// 비밀번호 입력 텍스트 필드
    @State var pwTextField: String = ""
    /// 비밀번호 검사 텍스트 필드
    @State var pwAgainTextField: String = ""
    
    @State var isDisablePassword: Bool = true
    
    var body: some View {
        VStack {
            HeaderView
            
            InputView
        }
        // Navigation View 관련 설정
        .navigationTitle("비밀번호 재설정")
        .navigationBarTitleDisplayMode(.inline)
        // 비밀번호 초기화 성공 시 alert
        .alert("비밀번호 변경 성공", isPresented: $VM.isAvaliable) {
            Button("확인", action: { self.presentationMode.wrappedValue.dismiss() })
        } message: {
            Text("비밀번호가 변경되었습니다.")
        }
        // 비밀번호 초기화 실패 시 alert
        .alert("입력 오류", isPresented: $VM.isError) {
            Button("확인", action: { })
        } message: {
            Text("비밀번호 변경에 실패하였습니다.\n 다시 한 번 확인해주세요.")
        }
    }
}

// MARK: Components
extension ResetPWView {
    /// 비밀번호 찾기 뷰 헤더
    private var HeaderView: some View {
        VStack {
            Image("Logo")
            Text("비밀번호를 재설정합니다.")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .foregroundColor(.theme.accent)
                .padding(.bottom, 33)
        }
    }
    
    /// 비밀번호 입력에 필요한 정보를 입력하는 Input View
    private var InputView: some View {
        VStack {
            ZStack {
                SecureField("변경할 비밀번호를 입력하세요.", text: $pwTextField)
                    .customTextField(padding: 13)
                    .frame(width: 288, alignment: .center)
                    .font(.custom(Font.theme.mainFont, size: 15))
                    .onChange(of: pwTextField) { newValue in
                        checkPW()
                    }
                HStack {
                    Spacer()

                    Image(systemName: "person.badge.key")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.trailing, 10)
                    

                }
                .frame(width: 288)
            }
            
            ZStack {
                SecureField("비밀번호를 다시 입력하세요.", text: $pwAgainTextField)
                    .customTextField(padding: 13)
                    .frame(width: 288, alignment: .center)
                    .font(.custom(Font.theme.mainFont, size: 15))
                    .onChange(of: pwAgainTextField) { newValue in
                        checkPW()
                    }
                
                HStack {
                    Spacer()

                    Image(systemName: "person.badge.key.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(.trailing, 10)
                }
                .frame(width: 288)
            }
            
            Button {
                resetPW()
            } label: {
                Text("비밀번호 변경")
                    .frame(width: 288, height: 40, alignment: .center)
                    .background(isDisablePassword ? Color.theme.secondary: Color.theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)

            }
            .disabled(isDisablePassword)
            .padding(.top, 30)

        }
    }

    
}

// MARK: - Functions
extension ResetPWView {
    private func resetPW() {
        guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        VM.doResetPW(data: ResetPWModel(userPassword: pwAgainTextField, userUuid: UUID))
        print("비밀번호 재설정 완료")
    }
    
    /// 패스워드, 패스워드 확인 텍스트가 같은지 확인
    private func checkPW() {
        print("passwordField == \(pwTextField), PWAgain == \(pwAgainTextField)")
        if (pwTextField == pwAgainTextField) && (pwTextField != "") {
            isDisablePassword = false
        }
        else {
            isDisablePassword = true
        }
    }
}


struct ResetPWView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPWView()
    }
}
