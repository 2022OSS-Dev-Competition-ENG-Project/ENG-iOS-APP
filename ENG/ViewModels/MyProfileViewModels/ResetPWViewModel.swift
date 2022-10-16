//
//  ResetPWViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/10/15.
//

import Foundation
import Combine

class ResetPWViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    var NM = NetworkManager.shared
    
    /// 비밀번호 초기화 성공을 알리는 변수
    @Published var isAvaliable: Bool = false
    /// 비밀번호 초기화 실패를 알리는 변수
    @Published var isError: Bool = false
    
    /**
     비밀번호 재설정 메서드
      
      - 비밀번호 재설정 성공 시
        - **isAvaliable** -> true
     
     - 비밀번호 재설정 실패 시
        - **isError** -> true
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameter data: ResetPassword API에 맞는 Request Data
     */
    func doResetPW(data: ResetPWModel) {
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/user-service/myPage/changePW", data: upLoadData, ip: NM.serverAddress)
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
                print("비밀번호 재설정 statusCode == \(statusCode)")
                
                if statusCode == 200 {
                    print("비밀번호 재설정 성공")
                    print("\(String(decoding: data, as: UTF8.self))")
                    let returnString = String(decoding: data, as: UTF8.self)
                    print(returnString)
                    self?.isAvaliable = true
                } else {
                    print("비밀번호 재설정 실패")
                    self?.isError = true
                }
            }
            .store(in: &cancellables)
    }
}
