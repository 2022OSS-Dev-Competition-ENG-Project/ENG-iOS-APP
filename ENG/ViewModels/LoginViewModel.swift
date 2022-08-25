//
//  LoginViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    static let shared = {
        return LoginViewModel()
    }()
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var isLoginSuccess: Bool = false
    @Published var isLoginFail: Bool = false
    @Published var isLoggedIn: Bool = false
    
    init() {
        guard let token = UserDefaults.standard.string(forKey: "loginToken") else { return }
        
        if !token.isEmpty {
            isLoggedIn = true
            print("-----> 로그인 토큰은 이거에요 \(token)")
        } else {
            print("로그인 토큰 없음 토큰 값 == \(token)")
        }
       
    }
    
    func doLogin(data: LoginRequest) {
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/api/user-service/login", data: upLoadData, ip: NM.userIp)
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
                    let token = String(decoding: data, as: UTF8.self)
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
    
    func doLogOut() {
        UserDefaults.standard.removeObject(forKey: "loginToken")
        isLoggedIn = false
        print("로그인 토큰 삭제 -----> \(String(describing: UserDefaults.standard.string(forKey: "loginToken")))")
    }
}
