//
//  MyPageViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/31.
//

import Foundation
import Combine
import UIKit

/// 마이프로필에서 사용하는 뷰 모델
/// - Note: Related with `MyProfileView`
class MyProfileViewModel: ObservableObject {
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    /// 사용자 기본 정보를 저장하는 프로퍼티
    @Published var userInfo: MyPageUserInfoModel = MyPageUserInfoModel(userEmail: "", userNickname: "", userJoinDate: "", userImg: "")
    /// 내가 쓴 게시물 목록 미리보기를 저장하는 프로퍼티
    @Published var mainMyContents: [MainMyPoster] = []
    /// 내가 신고한 목록 미리보기를 저장하는 프로퍼티
    @Published var mainMyReports: [MainMyReport] = []
    /// 프로필 사진 업로드 성공 시 동작하는 프로퍼티
    @Published var isUploadSucess: Bool = false
    
    /// 뷰 모델 생성 시 사용자 정보, 내가 쓴 게시물, 나의 신고 목록을 불러옴
    init() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        getUserInfo(userUUID: userUUID)
        get5MyContents(userUUID: userUUID)
//        get5MyReports(userUUID: userUUID)
    }
    
    /**
     사용자 정보를 불러오는 메서드
      
      - 성공 시
        - `userInfo`에 정보 저장
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameter userUUID: 사용자 UUID 값
    */
    func getUserInfo(userUUID: String) {
        guard let url = URL(string: NM.serverAddress + "/user-service/myPage/" + userUUID) else { return }
        
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
    
    /**
     내가 쓴 게시물 리스트 5개를 불러오는 메서드
      
      - 성공 시
        - `mainMyContents`에 정보 저장
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameter userUUID: 사용자 UUID 값
    */
    func get5MyContents(userUUID: String) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/my/content/main/" + userUUID) else { return }
        
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
    
    /**
     내가 신고한 목록 5개를 불러오는 메서드
      
      - 성공 시
        - `mainMyReport`에 정보 저장
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameter userUUID: 사용자 UUID 값
    */
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
    
    /// Status 코드에 따른 매핑 핸들러
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200
        else {
            print("통신에러 \(output.response)")
            throw URLError(.badServerResponse)
        }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
    
    /**
     유저 프로필 사진을 등록하는 메서드
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameters:
        - paramName: Content Disposition의 name
        - fileName: 저장할 파일 명 지정
        - image: UIImage형태의 이미지
    */
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
