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
        guard let url = URL(string: NM.facilityIp + "/api/facility/" + userUUID + "/list") else { return }

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

        print("response.StatusCode == \(response.statusCode), data == \(output.data)")
        
        return output.data
    }
    
    func deleteFacility(indexSet: IndexSet) {
        print("지우기")
        print("--=---> \(indexSet)")
        MyFacilities.remove(atOffsets: indexSet)
    }
}
