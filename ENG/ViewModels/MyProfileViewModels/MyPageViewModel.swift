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
    @Published var mainMyContents: [MainMyPoster] = []
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
    func get5MyContents(userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/main/user/" + userUUID) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [MainMyPoster].self, decoder: JSONDecoder())
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
    func get5MyReports(userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/report/list/main/" + userUUID) else { return }
        
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
        // UUID 호출
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        // 이미지를 UIImage로 저장
        let images: [UIImage] = [image]
        
        // 폼 데이터 통신에 사용할 바운더리 생성
        let boundary = UUID().uuidString
        
        // urlRequest 생성
        let urlRequest = NM.makeFormDataURLRequest(ipAddress: NM.userIp, api: "/api/user-service/SaveProfileImage/" + userUUID, boundary: boundary)
        
        // 세션 불러오기
        let session = URLSession.shared
        
        // 이미지 데이터 생성
        var data = NM.makeImageDataForFormData(paramName: "images", images: images, boundary: boundary)
        
        // Form-Data의 끝을 알리는 바운더리 append
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            print("이미지 전송 StatusCode = \(statusCode)")
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.isUploadSucess = true
                }
            }
            
            if error != nil {
                print("이미지 전송 실패 error ---->\(String(describing: error))")
            }
        }).resume()
    }
}
