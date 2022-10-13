//
//  MyFacilityViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation
import Combine

/// 시설 리스트에 사용할 뷰 모델
/// - Note: Related with `FacilityView`
class MyFaciltyViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    /// 시설 리스트 모델
    @Published var MyFacilities: [MyFacilityModel] = []

    /// 뷰 모델 생성 시 모델을 불러 옴
    init() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        print(userUUID)
        getFacilities(userUUID: userUUID)
        print(MyFacilities)
    }
    
    /**
     사용자 UUID와 연관된 시설물 리스트를 불러오는 메서드
      
      - 성공 시
        - **MyFacilities**값 리턴
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameter userUUID: 사용자 UUID
    */
    func getFacilities(userUUID: String) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/join/" + userUUID + "/user/list") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [MyFacilityModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                self?.MyFacilities = returnedValue
            }
            .store(in: &cancellables)
    }
    
    /**
      tryMap Handler
     - Note: Related with getFacilities
    */
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200 || response.statusCode == 409
        else { throw URLError(.badServerResponse) }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
    
    /**
     내가 등록한 시설물을 삭제하는 메서드
      
      - 성공 시
        사용자가 등록한 시설물 제거
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameters:
        - indexSet: Facility List에서 선택된 행의 인덱스
        - userUUID: 삭제할 유저의 UUID
    */
    func deleteFacility(indexSet: IndexSet, userUUID: String) {
        print("지우기")
        print("--=---> \(indexSet)")
        guard let indexToRemove = indexSet.first else { return }
        let facilityIdToRemove = MyFacilities[indexToRemove].id
        MyFacilities.remove(atOffsets: indexSet)
        
        guard let url = URL(string: NM.serverAddress + "/facility-service//resignation/user/" + facilityIdToRemove + "/" + userUUID) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap({ (data, response) in
                print(String(decoding: data, as: UTF8.self))
                guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
                if httpResponse.statusCode == 200 {
                    print("시설물 삭제 200ok")
                } else {
                    print("시설물 삭제 실패 \(httpResponse)")
                }
                print(String(decoding: data, as: UTF8.self))
                
                return data
            })
            .decode(type: [MyFacilityModel].self, decoder: JSONDecoder())
            .sink { completion in
                print(completion)
            } receiveValue: { returnedValue in

            }
            .store(in: &cancellables)
    }
    
    /**
     내가 등록한 시설물을 좋아요/좋아요 취소하는 메서드
      
      - 성공 시
        좋아요/좋아요 취소
     
     [참고 API URL](https://xxx.xxx.xxx.xx)
     
     - Parameters:
        - userUUID: 좋아요할 유저의 UUID
        - faclityUUID: 좋아요할 시설물의 UUID
    */
    func likeFaiclity(userUUID: String, faclityUUID: String) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/join/like/" + userUUID + "/" + faclityUUID) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0
            }
            .sink { completion in
                print(completion)
            } receiveValue: { returnedValue in
                guard let response = returnedValue.response as? HTTPURLResponse else { return }
                print(response.statusCode)
                if response.statusCode == 200 {
                    let seletedFacility = self.MyFacilities.firstIndex { item in
                        return item.id == faclityUUID
                    }!
                    if self.MyFacilities[seletedFacility].isLikedBool {
                        self.MyFacilities[seletedFacility].likeBool = 0
                    } else {
                        self.MyFacilities[seletedFacility].likeBool = 1
                    }
                }
                
                
            }
            .store(in: &cancellables)
    }
}
