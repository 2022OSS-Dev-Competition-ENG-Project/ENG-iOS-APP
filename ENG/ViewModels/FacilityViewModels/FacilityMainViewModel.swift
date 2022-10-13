//
//  FacilityDetailMainViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/25.
//

import Foundation
import Combine

/// 시설 메인 뷰에서 사용하는 뷰 모델
/// - Note: Related with `FacilityMainView`
class FacilityMainViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    /// 게시물 리스트를 저장하는 프로퍼티
    @Published var posters: [FacilityPosterModel] = []
    /// 공지사항 리스트를 저장하는 프로퍼티
    @Published var notices: [FacilityNoticeModel] = []
    
    /// 게시물 불러오기 메서드
    func get5Posters(faciliityId: String) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/content/" + faciliityId + "/main") else { return }
        
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
    
    /// 공지사항 불러오기
    func get5Notices(facilityId: String) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/notice/" + facilityId + "/main") else { return }
                
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [FacilityNoticeModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("노티스 불러오기 완료 ---->> \(returnedValue)")
                self?.notices = returnedValue
            }
            .store(in: &cancellables)
    }
    
    /// 통신 데이터 핸들러
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200
        else { throw URLError(.badServerResponse) }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
    
}
