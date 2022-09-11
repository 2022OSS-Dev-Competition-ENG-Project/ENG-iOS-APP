//
//  FindIdViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/25.
//

import Foundation
import Combine
import SwiftUI

/// 아이디 찾기 뷰에서 사용되는 뷰 모델
class FindIdViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var NM = NetworkManager.shared
    
    /// 리턴된 User Email 값을 저장하는 변수
    @Published var userEmail: String = ""
    /// 아이디 찾기 성공 시 alert을 제어하기 위한 변수
    @Published var isFoundId: Bool = false
    /// 아이디를 찾기 실패 시 alert을 제어하기 위한 변수
    @Published var isCanNotFindId: Bool = false
    
    
    /**
     아이디 찾기를 위한 통신을 시작하는 메서드
      
      - 아이디 찾기 성공 시
        - UserEmail을 리턴
        - isFoundedId를 True로 리턴
     
     - 아이디 찾기 실패 시
        - isCanNotFindId를 True로 리턴
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameter data: 아이디를 찾을 유저의 정보
    */
    func doFindId(data: FindIdModel) {
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/api/user-service/FindUserid", data: upLoadData, ip: NM.userIp)
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
                print("아이디 찾기 statusCode == \(statusCode)")
                
                if statusCode == 200 {
                    print("아이디 찾기 성공")
                    print("userEmail => \(String(decoding: data, as: UTF8.self))")
                    let returnString = String(decoding: data, as: UTF8.self)
                    self?.userEmail = returnString
                    self?.isFoundId = true
                } else {
                    print("아이디 찾기 실패")
                    self?.isCanNotFindId = true
                }
            }
            .store(in: &cancellables)
    }
}
