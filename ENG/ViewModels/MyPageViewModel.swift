//
//  MyPageViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/31.
//

import Foundation
import Combine

class MyPageViewModel: ObservableObject {
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var userInfo: MyPageUserInfoModel = MyPageUserInfoModel(userEmail: "", userNickname: "", userJoinDate: "")
    
    init() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        getUserInfo(userUUID: userUUID)
    }
    
    // get UserInfo
    func getUserInfo(userUUID: String) {
        guard let url = URL(string: NM.userIp + "/api/user-service/myPage/" + userUUID) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: MyPageUserInfoModel.self, decoder: JSONDecoder())
            .replaceError(with: MyPageUserInfoModel(userEmail: "", userNickname: "", userJoinDate: ""))
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 리턴 벨류\(returnedValue)")
                self?.userInfo = returnedValue
            }
            .store(in: &cancellables)
    }
    
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200
        else { throw URLError(.badServerResponse) }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
}
