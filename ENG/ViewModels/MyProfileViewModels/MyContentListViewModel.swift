//
//  MyContentListViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/04.
//

import Foundation
import Combine

/// 내가 등록한 게시물 리스트 뷰에서 사용하는 뷰 모델
/// - Note: Related with `MyposterListView`
class MyContentListViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    /// 게시물 리스트 저장 프로퍼티
    @Published var contents: [MyPosterListModel] = []
    
    /// 뷰 모델 생성 시 게시물 리스트 불러옴
    init() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        getContents(userUUID: userUUID)
    }
    
    /// 게시물 리스트를 불러오는 프로퍼티
    func getContents(userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/my/content/" + userUUID) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [MyPosterListModel].self, decoder: JSONDecoder())
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
