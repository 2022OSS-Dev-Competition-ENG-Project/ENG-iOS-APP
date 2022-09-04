//
//  MyPageViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/31.
//

import Foundation
import Combine
import UIKit

class MyPageViewModel: ObservableObject {
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var userInfo: MyPageUserInfoModel = MyPageUserInfoModel(userEmail: "", userNickname: "", userJoinDate: "", userImg: "")
    @Published var mainMyContents: [MainMyContent] = []
    @Published var mainMyReports: [MainMyReport] = []
    @Published var isUploadSucess: Bool = false
    
    init() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        getUserInfo(userUUID: userUUID)
        get5MyContents(userUUID: userUUID)
        get5MyReports(userUUID: userUUID)
    }
    
    // get UserInfo
    func getUserInfo(userUUID: String) {
        guard let url = URL(string: NM.userIp + "/api/user-service/myPage/" + userUUID) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: MyPageUserInfoModel.self, decoder: JSONDecoder())
            .replaceError(with: MyPageUserInfoModel(userEmail: "", userNickname: "", userJoinDate: "", userImg: ""))
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 리턴 벨류\(returnedValue)")
                self?.userInfo = returnedValue
            }
            .store(in: &cancellables)
    }
    
    // get My 5 Contents
    // 수정 필요 건물 UUID 제외
    func get5MyContents(userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/main/user/" + userUUID + "/" + "247f9839-53a4-426c-994d-878f1c05d47b") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [MainMyContent].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 내가 등록한 게시물 : \(returnedValue)")
                self?.mainMyContents = returnedValue
            }
            .store(in: &cancellables)
    }
    
    // get My 5 Report
    // 수정 필요 건물 UUID 제외
    func get5MyReports(userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/report/list/main/" + "247f9839-53a4-426c-994d-878f1c05d47b" + "/" + userUUID) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [MainMyReport].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 내가 등록한 게시물 : \(returnedValue)")
                self?.mainMyReports = returnedValue
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
    
    
    // 유저 프로필 사진 등록
    func registerUserProfileImage(paramName: String, fileName: String, image: UIImage) {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        let images: [UIImage] = [image]
        NM.uploadImages(ipAddress: NM.userIp, paramName: paramName, fileName: fileName, images: images, userUUID: userUUID) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.isUploadSucess = true
                }
            }
        }
    }
}
