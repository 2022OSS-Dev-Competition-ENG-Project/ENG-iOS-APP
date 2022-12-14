//
//  SignUpView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

// MARK: - MainViewStruct
struct SignUpView: View {
    
    // NavigationView Dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // 회원가입 뷰 모델
    @StateObject var VM = SignUpViewModel.shared
    
    // 계정 정보 TextField
    @State var eMailTextField: String = ""
    @State var passWordTextField: String = ""
    @State var PWAgainTextField: String = ""
    @State var eMailCodeTextField: String = ""
    
    // 회원 정보 TextField
    @State var nameTextField: String = ""
    @State var nicknameTextField: String = ""
    @State var phonenumberTextField: String = ""
    
    // 비밀 번호 같은지 확인
    @State var isDisablePassword: Bool = true
    
    // 인증 여부에 따른 UI 제어
    @State var isEMailSend: Bool = false
    @State var isAuthenticated: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HeaderView
                
                AccountInfoInputView
                
                // 이메일 인증 성공 시 뷰
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
                // 이메일 인증 미실행 시 뷰
                else {
                    Button {
                        if isEMailSend {
                            emailAuthenticate()
                        } else {
                            emailSend()
                        }
                    } label: {
                        Text(isEMailSend ? "이메일 인증": "인증 코드 보내기")
                            .frame(width: 288, height: 40, alignment: .center)
                            .background(isDisablePassword ? Color.theme.secondary: Color.theme.accent)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    }
                    .disabled(isDisablePassword)
                }
                Spacer()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        // 이메일 보내기 성공 시 alert
        .alert("이메일 보내기 성공!", isPresented: $VM.isSuccess) {
            Button("확인", action: { isEMailSend = true})
        }
        // 이메일 보내기 실패 시 (이메일 중복) alert
        .alert("이메일 보내기 실패", isPresented: $VM.isDuplicate) {
            Button("확인", action: { })
        } message: {
            Text("이미 존재하는 이메일입니다.")
        }
        // 이메일 보내기 실패 시 (Server Error) alert
        .alert("이메일 보내기 실패", isPresented: $VM.isFail) {
            Button("확인", action: { })
        } message: {
            Text("네트워크 상의 문제로 이메일 전송에 실패하였습니다.")
        }
        // 이메일 인증 성공 시 alert
        .alert("이메일 인증 성공!", isPresented: $VM.isAvailableAuthCode) {
            Button("확인", action: { isAuthenticated = true })
        }
        // 이메일 인증 실패 시 alert
        .alert("이메일 인증 실패", isPresented: $VM.isDisableAuthCode) {
            Button("확인", action: { })
        }
        // 회원가입 성공 시 alert
        .alert("회원가입 성공!", isPresented: $VM.isSuccessSignUp) {
            Button("확인", action: { self.presentationMode.wrappedValue.dismiss() })
        }
        // Navigation View 관련 설정
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

// MARK: - Components
extension SignUpView {
    /// 헤더 뷰
    private var HeaderView: some View {
        VStack {
            Image("Logo")
            Text("새로운 계정을 생성합니다.")
                .font(.custom(Font.theme.mainFontBold, size: 15))
                .foregroundColor(.theme.accent)
                .padding(.bottom, 33)
        }
    }
    
    /// 계정 정보 입력 뷰
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
                .disabled(isEMailSend)
                .keyboardType(.emailAddress)
            
            SecureField("비밀번호를 입력하세요.", text: $passWordTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
                .disabled(isAuthenticated)
                .onChange(of: passWordTextField) { newValue in
                    checkPW()
                }
            
            SecureField("비밀번호를 다시 입력하세요.", text: $PWAgainTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 23)
                .disabled(isAuthenticated)
                .onChange(of: PWAgainTextField) { newValue in
                    checkPW()
                }
            
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

    /// 회원 정보 입력 뷰
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
            
            Text(VM.isAvailableNickName ? "사용 가능한 닉네임입니다.": "사용 불가능한 닉네임입니다.")
                .font(.caption)
                .foregroundColor(VM.isAvailableNickName ? Color.theme.green : Color.theme.red)
                .frame(width: 290, alignment: .trailing)
            TextField("닉네임을 입력하세요.", text: $nicknameTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
                .onChange(of: nicknameTextField) { newValue in
                    nicknameCheck()
                }

            TextField("휴대폰 번호를 입력하세요.", text: $phonenumberTextField)
                .customTextField(padding: 10)
                .frame(width: 290, height: 40, alignment: .center)
                .padding(.bottom, 12)
                .keyboardType(.numberPad)
        }
    }
}

// MARK: - Functions
extension SignUpView {
    /// 회원가입 시도 메서드
    private func signUp() {
        let signUpModel: SignUpModel = SignUpModel(userEmail: eMailTextField, userPassword: passWordTextField, userName: nameTextField, userNickname: nicknameTextField, userPhoneNumber: phonenumberTextField)
        VM.signUp(data: signUpModel)
    }
    
    /// 인증 코드 전송 메서드
    private func emailSend() {
        print("인증 코드 전송")
        VM.emailAuthenticateStart(email: eMailTextField)
    }
    
    /// 인증 코드 확인 메서드
    private func emailAuthenticate() {
        print("인증 코드 확인")
        VM.emailAuthenticate(email: eMailTextField, code: eMailCodeTextField)
    }
    
    /// 백그라운드 터치 시 키보드 숨김
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    /// 패스워드, 패스워드 확인 텍스트가 같은지 확인
    private func checkPW() {
        print("passwordField == \(passWordTextField), PWAgain == \(PWAgainTextField)")
        if (passWordTextField == PWAgainTextField) && (passWordTextField != "") {
            isDisablePassword = false
        }
        else {
            isDisablePassword = true
        }
    }
    
    /// 닉네임 체크 메서드
    private func nicknameCheck() {
        print("닉네임 체크 ㄱ")
        VM.checkNickName(email: eMailTextField, nickName: nicknameTextField)
    }
}

// MARK: - Preview
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
        
    }
}
