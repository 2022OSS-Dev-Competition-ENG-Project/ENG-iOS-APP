//
//  LoginView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI
/*
    FocusState 사용법
 
    Focused(_:) : https://developer.apple.com/documentation/swiftui/label/focused(_:)
    Focused(_:equals:) : https://developer.apple.com/documentation/swiftui/view/focused(_:equals:)
 */
// MARK: - MainViewStruct
struct LoginView: View {
    
    // Hashable 프로토콜을 통해 ==(equatable) 하도록 함
    enum Field: Hashable {
        case idTextField
        case pwdTextField
    }
    
    /// MyPageView에서 LoginViewModel을 전달 받음
    @EnvironmentObject var loginVM: LoginViewModel
    
    /// 아이디 값을 입력 받는 텍스트 필드
    @State var idTextField: String = ""
    /// 비밀 번호 값을 입력 받는 텍스트 필드
    @State var pwdTextField: String = ""
    /// SignUp View로 이동하기 위한 변수
    @State var isSignUpTabbed: Bool = false
    /// 에러 발생 시 alert을 제어하는 변수
    @State var isError: Bool = false
    /// 현재 Focus 상태인 텍스트 필드 감지
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            
            InputView
            
            Spacer()
            
            SignUpButtonView
                .padding(.bottom, 15)

        }
        .onTapGesture {
            hideKeyboard()
        }
        // Navigation View 관련 속성
        .navigationTitle("로그인")
        .navigationBarTitleDisplayMode(.inline)
        // 아이디 비밀번호 인풋을 비웠을 시 오류 출력
        .alert("입력 오류", isPresented: $isError) {
            Button("OK") {isError = false}
        } message: {
            Text("아이디/비밀번호를 입력하세요.")
        }
        // 일치하는 계정이 없을 시 오류 출력
        .alert("로그인 실패", isPresented: $loginVM.isLoginFail) {
            Button("확인") { }
        } message: {
            Text("아이디나 비밀번호가 일치하지 않습니다.")
            Text("다시 한 번 확인해 주세요.")
        }
    }
}

// MARK: - Components
extension LoginView {
    // MARK: - Input View
    private var InputView: some View {
        VStack(spacing: 16) {
            IDInputView
            
            PasswordInputView
           
            LoginButton

            FindAccountButton

        }
        .frame(height: UIScreen.main.bounds.height * 0.7)
    }
    
    /// 아이디 입력 인풋 뷰
    private var IDInputView: some View {
        ZStack {
            TextField("아이디를 입력하세요.", text: $idTextField)
                .focused($focusedField, equals: .idTextField)
                .customTextField(padding: 13)
                .frame(width: 288, alignment: .center)
                .font(.custom(Font.theme.mainFont, size: 15))
                .keyboardType(.emailAddress)
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
    }
    
    /// 비밀번호 입력 인풋 뷰
    private var PasswordInputView: some View {
        ZStack {
            SecureField("비밀번호를 입력하세요.", text: $pwdTextField)
                .focused($focusedField, equals: .pwdTextField)
                .customTextField(padding: 13)
                .frame(width: 288, alignment: .center)
                .font(.custom(Font.theme.mainFont, size: 15))
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
    }
    
    /// 로그인 버튼
    private var LoginButton: some View {
        Button {
            // 텍스트 필드 검사
            if idTextField.isEmpty {
                focusedField = .idTextField
                isError = true
            } else if pwdTextField.isEmpty {
                focusedField = .pwdTextField
                isError = true
            } else {
                Login()
            }
        } label: {
            Text("로그인")
                .frame(width: 288, height: 40, alignment: .center)
                .foregroundColor(.white)
                .background(Color.theme.accent)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        }
    }
    
    /// 아이디 비밀번호 찾기 버튼
    private var FindAccountButton: some View {
        NavigationLink("계정 정보를 잊으셨나요?") {
            FindAccountView()
        }
        .foregroundColor(.theme.sub)
        .font(.custom(Font.theme.mainFontBold, size: 12))
        .frame(width: 288, alignment: .leading)
    }
    
    // MARK: - Footer View
    private var SignUpButtonView: some View {
        HStack {
            Text("아직 계정이 없으신가요?")
                .foregroundColor(.theme.secondary)
            Text("SignUp")
                .foregroundColor(.theme.sub)
            NavigationLink("", destination: SignUpView(), isActive: $isSignUpTabbed)
        }
        .font(.custom(Font.theme.mainFontBold, size: 12))
        .onTapGesture {
            isSignUpTabbed.toggle()
        }
    }
}

// MARK: - Functions
extension LoginView {
    /// 로그인 시행 메서드
    private func Login() {
        print("로그인 시도")
        loginVM.doLogin(data: LoginRequest(userEmail: idTextField, userPassword: pwdTextField))
    }
    
    /// 백그라운드 터치 시 키보드 숨김
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
        .environmentObject(LoginViewModel())
    }
}
