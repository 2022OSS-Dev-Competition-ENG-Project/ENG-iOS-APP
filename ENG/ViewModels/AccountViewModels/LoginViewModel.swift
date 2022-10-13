//
//  LoginViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation
import Combine

/// 로그인 뷰에서 사용되는 뷰 모델
/// - Note: Related with `LoginView`, `MyPageView`, `FacilityView`
class LoginViewModel: ObservableObject {
    
    /// 로그인 모델을 각기 다른 뷰에서 사용할 수 있도록 싱글톤 패턴 활용
    static let shared = {
        return LoginViewModel()
    }()
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    /// 로그인 성공 시 alert 제어 변수
    @Published var isLoginSuccess: Bool = false
    /// 로그인 실패 시 alert 제어 변수
    @Published var isLoginFail: Bool = false
    /// 이미 로그인 한 상태인지 확인하는 변수
    @Published var isLoggedIn: Bool = false
    
    /// 앱 실행 시 로그인 여부를 가장 먼저 확인
    init() {
        guard let token = UserDefaults.standard.string(forKey: "loginToken") else { return }
        
        if !token.isEmpty {
            isLoggedIn = true
            print("-----> 로그인 토큰은 이거에요 \(token)")
        } else {
            print("로그인 토큰 없음 토큰 값 == \(token)")
        }
       
    }
    
    /**
     로그인을 시도하는 메서드
      
      - 로그인 성공 시
        - **isLoginSuccess** -> true
        - **isLoggedIn** -> true
        - UserDefault에 해당 유저의 **UUID** 값 저장
     
     - 로그인 실패 시
        - **isLoginFail** -> true
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameter data: Login API에 맞는 Request Data
    */
    func doLogin(data: LoginRequest) {
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/user-service/login", data: upLoadData, ip: NM.serverAddress)
        } catch(let error) {
            print("error: \(error)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0
            }
            .sink { completion in
                print(completion)
            } receiveValue: {[weak self] (data, response) in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                print("회원가입 statusCode == \(statusCode)")
                if statusCode == 200 {
                    print("로그인 성공")
                    self?.isLoginSuccess = true
                    
                    // 데이터 파싱
                    let decodeData = try? JSONDecoder().decode(LoginResponse.self, from: data)
                    guard let token = decodeData?.body else { return }
                    
                    // UserDefaults에 UserUUID 저장
                    UserDefaults.standard.set(token, forKey: "loginToken")
                    print("유저 디폴트에 저장된 값 = \(String(describing: UserDefaults.standard.string(forKey: "loginToken")))")
                    self?.isLoggedIn = true
                } else {
                    print("회원정보가 일치 하지 않음.")
                    self?.isLoginFail = true
                }
            }
            .store(in: &cancellables)
    }
    
    /**
     로그아웃을 위한 메서드
      
     - UserDefault의 loginToken key에 해당하는 값 제거
     - **isLoggedIn** -> false
    */
    func doLogOut() {
        UserDefaults.standard.removeObject(forKey: "loginToken")
        isLoggedIn = false
        print("로그인 토큰 삭제 -----> \(String(describing: UserDefaults.standard.string(forKey: "loginToken")))")
    }
}
