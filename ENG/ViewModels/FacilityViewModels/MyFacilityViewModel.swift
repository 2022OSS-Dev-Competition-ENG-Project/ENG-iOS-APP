//
//  MyFacilityViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation
import Combine



class MyFaciltyViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var MyFacilities: [MyFacilityModel] = []

    init() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        print(userUUID)
        getFacilities(userUUID: userUUID)
        print(MyFacilities)
    }
    
    // get facilities
    func getFacilities(userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/join/" + userUUID + "/us/list") else { return }

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
    
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200 || response.statusCode == 409
        else { throw URLError(.badServerResponse) }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
    
    // 시설물 삭제
    func deleteFacility(indexSet: IndexSet, userUUID: String) {
        print("지우기")
        print("--=---> \(indexSet)")
        guard let indexToRemove = indexSet.first else { return }
        let facilityIdToRemove = MyFacilities[indexToRemove].id
        MyFacilities.remove(atOffsets: indexSet)
        
        guard let url = URL(string: NM.facilityIp + "/api/facility/my/delete/us/" + userUUID + "/" + facilityIdToRemove) else { return }

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
    
    // 시설물 좋아요
    func likeFaiclity(userUUID: String, faclityUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/like/" + userUUID + "/" + faclityUUID) else { return }
        
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
                        self.MyFacilities[seletedFacility].isLiked = 0
                    } else {
                        self.MyFacilities[seletedFacility].isLiked = 1
                    }
                }
                
                
            }
            .store(in: &cancellables)
    }
}
