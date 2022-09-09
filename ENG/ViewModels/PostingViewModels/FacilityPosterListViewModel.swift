//
//  FacilityPosterListViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation
import Combine

class FacilityPosterListViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var posters: [FacilityPosterModel] = []
    
    func getPosters(faciliityId: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/" + faciliityId + "/0/0/list") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [FacilityPosterModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 리턴 벨류\(returnedValue)")
                self?.posters = returnedValue
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
