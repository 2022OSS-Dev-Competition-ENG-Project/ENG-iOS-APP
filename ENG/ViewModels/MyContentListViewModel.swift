//
//  MyContentListViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/04.
//

import Foundation
import Combine

class MyContentListViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var contents: [MyContentListModel] = []
    
    init() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        getContents(userUUID: userUUID)
    }
    
    func getContents(userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/user/" + userUUID + "/" + "247f9839-53a4-426c-994d-878f1c05d47b") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [MyContentListModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 리턴 벨류\(returnedValue)")
                self?.contents = returnedValue
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
