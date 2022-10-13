//
//  FacilityPosterListViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation
import Combine

/// 시설의 게시물 리스트 뷰에서 사용되는 뷰 모델
/// - Note: Related with `FacilityPosterListView`
class FacilityPosterListViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    /// 수신된 게시물 리스트를 저장하는 프로퍼티
    @Published var posters: [FacilityPosterModel] = []
    
    /// 게시물 리스트 불러오기 메서드
    func getPosters(faciliityId: String) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/content/" + faciliityId) else { return }
        
        print(url)
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
