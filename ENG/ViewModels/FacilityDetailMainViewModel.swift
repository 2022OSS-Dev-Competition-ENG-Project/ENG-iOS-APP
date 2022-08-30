//
//  FacilityDetailMainViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/25.
//

import Foundation
import Combine

class FacilityDetailMainViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var posters: [FacilityPosterModel] = []
    @Published var notices: [FacilityNoticeModel] = []
    
    // get 5 Posters
    func get5Posters(faciliityId: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/" + faciliityId + "/content/0/main") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [FacilityPosterModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                self?.posters = returnedValue
            }
            .store(in: &cancellables)
    }
    
    // get 5 Notices
    func get5Notices(facilityId: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/" + facilityId + "/content/1/main") else { return }
                
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [FacilityNoticeModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                self?.notices = returnedValue
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
