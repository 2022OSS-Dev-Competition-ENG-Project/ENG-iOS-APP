//
//  SignUpViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/23.
//

import Foundation
import Combine

/// 회원가입 뷰에서 사용되는 뷰 모델
/// - Note: Related with `SignUpView`
class SignUpViewModel: ObservableObject {
    let NM = NetworkManager.shared
    
    var cancellables = Set<AnyCancellable>()
    
    static let shared: SignUpViewModel = {
        return SignUpViewModel()
    }()
    
    // 이메일 중복 점검 관련 프로퍼티
    @Published var isSuccess: Bool = false
    @Published var isDuplicate: Bool = false
    @Published var isFail: Bool = false
    
    // 이메일 인증 코드 점검 프로퍼티
    @Published var isAvailableAuthCode: Bool = false
    @Published var isDisableAuthCode: Bool = false
    
    // 닉네임 중복 검사 관련 프로퍼티
    @Published var isAvailableNickName: Bool = false
    @Published var isDisableNickName: Bool = false
    
    // 회원가입 성공 여부
    @Published var isSuccessSignUp: Bool = false
    
    // MARK: 회원가입 관련 메서드
    /// 이메일 인증 시작
    func emailAuthenticateStart(email: String) {
        guard let url = URL(string: NM.serverAddress + "/user-service/register/check/email/" + email) else { return }

        var statusCode: Int = 0
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap({ (data, response) in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 || response.statusCode == 409
                else { return }
                statusCode = response.statusCode
                print("response.StatusCode == \(response.statusCode), data == \(data)")
            })
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] data in
                if statusCode == 200 {
                    self?.isSuccess = true
                } else if statusCode == 409 {
                    self?.isDuplicate = true
                } else {
                    self?.isFail = true
                }
            }
            .store(in: &cancellables)
    }
    
    /// 이메일 인증 코드 검증
    func emailAuthenticate(email: String, code: String) {
        guard let url = URL(string: NM.serverAddress + "/user-service/register/check/email/" + email + "/" + code) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0.response as? HTTPURLResponse
            }
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self]data in
                guard let statusCode = data?.statusCode else { return }
                print(statusCode)
                if statusCode == 200 {
                    self?.isAvailableAuthCode = true
                } else {
                    self?.isDisableAuthCode = true
                }
            }
            .store(in: &cancellables)
    }
    
    /// 닉네임 중복 검사
    func checkNickName(email: String, nickName: String) {
        guard let url = URL(string: NM.serverAddress + "/user-service/register/check/nickname/" + nickName) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0.response as? HTTPURLResponse
            }
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self]data in
                guard let statusCode = data?.statusCode else { return }

                if statusCode == 200 {
                    self?.isAvailableNickName = true
                } else {
                    self?.isAvailableNickName = false
                }
            }
            .store(in: &cancellables)
    }
    
    /// 회원 가입
    func signUp(data: SignUpModel) {
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/user-service/signup", data: upLoadData, ip: NM.serverAddress)
        } catch(let error) {
            print("error: \(error)")
            return
        }
        
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0.response as? HTTPURLResponse
            }
            .sink { completion in
                print(completion)
            } receiveValue: {[weak self] data in
                guard let statusCode = data?.statusCode else { return }
                print("회원가입 statusCode == \(statusCode)")
                if statusCode == 201 {
                    self?.isSuccessSignUp = true
                    print("회원가입 성공")
                }
            }
            .store(in: &cancellables)
    }
}
