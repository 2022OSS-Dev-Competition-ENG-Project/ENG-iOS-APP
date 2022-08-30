//
//  ContentDetailViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation
import Combine

class ContentDetailViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var content: ContentDetailModel = ContentDetailModel(contentNum: 1, contentTitle: "김어준 이준석의 승리..국힘서 무리수를 둔 것", contentText: "[이데일리 김민정 기자] 방송인 김어준 씨는 이준석 국민의힘 대표가 제기한 비상대책위원회 전환 효력 정지 가처분 신청이 법원에서 일부 인용된 것을 두고 “정치적으로 보면 이 전 대표의 승리”라고 했다. 김씨는 29일 자신이 진행하는 TBS 교통방송 ‘김어준의 뉴스공장’에서 이 전 대표가 최근 법원으로부터 ‘주호영 비대위원장 직무정지’ 가처분 결정을 끌어낸 것을 두고 이같이 말했다.", contentDate: "2022-08-30T00:00:00", contentLook: "100", userNickName: "CheolSuJjang")
    
    func getContent(userUUID: String, contentId: Int) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/" + userUUID + "/" + String(contentId)) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: ContentDetailModel.self, decoder: JSONDecoder())
            .replaceError(with: ContentDetailModel(contentNum: 1, contentTitle: "", contentText: "", contentDate: "", contentLook: "", userNickName: ""))
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 리턴 벨류\(returnedValue)")
                self?.content = returnedValue
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
