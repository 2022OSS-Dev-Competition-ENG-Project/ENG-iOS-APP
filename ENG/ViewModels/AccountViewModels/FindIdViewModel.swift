//
//  FindIdViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/25.
//

import Foundation
import Combine
import SwiftUI

class FindIdViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var NM = NetworkManager.shared
    
    @Published var userEmail: String = ""
    @Published var isFoundId: Bool = false
    @Published var isCanNotFindId: Bool = false
    
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
