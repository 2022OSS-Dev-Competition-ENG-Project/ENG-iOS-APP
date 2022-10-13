//
//  PosterDetailViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation
import Combine

/// 게시물 상세보기 뷰에서 사용되는 뷰
/// - Note: Related with `PosterDetailView`
class PosterDetailViewModel: ObservableObject {
    
    let NM = NetworkManager.shared
    var cancellables = Set<AnyCancellable>()
    
    /// 수신된 정보 저장 프로퍼티
    @Published var content: PosterDetailModel = PosterDetailModel(contentNum: 0, contentTitle: "", contentText: "", contentDate: "", contentLook: 0, writerNickName: "", writerProfileImg: "", writerUuid: "", userLikeBool: 0)
    /// 댓글 목록 리스트 저장 프로퍼티
    @Published var comments: [CommentModel] = []
    /// 좋아요 수 저장 프로퍼티
    @Published var likeCount: String = ""
    
    /// 게시물 삭제 여부 프로퍼티
    @Published var isDelete: Bool = false
    
    // MARK: - 포스터 관련 메서드
    /// 게시물 상세 정보 불러오기 메서드
    func getContent(userUUID: String, contentId: Int) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/content/" + userUUID + "/" + String(contentId)) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: PosterDetailModel.self, decoder: JSONDecoder())
            .replaceError(with: PosterDetailModel(contentNum: 1, contentTitle: "", contentText: "", contentDate: "", contentLook: 0, writerNickName: "", writerProfileImg: "", writerUuid: "", userLikeBool: 0))
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 리턴 벨류\(returnedValue)")
                self?.content = returnedValue
            }
            .store(in: &cancellables)
    }
    
    /// 게시물 삭제 메서드
    func deleteContent(userUUID: String, contentId: Int) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/delete/" + userUUID + "/" + String(contentId)) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0.response
            }
            .sink { completion in
                print(completion)
            } receiveValue: {[weak self] response in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                if statusCode == 200 {
                    print("-----> 게시물 삭제 성공!\n스테이터스 코드 : \(statusCode)")
                    self?.isDelete = true
                } else {
                    print("-----> 게시물 삭제 실패 ㅠ\n스테이터스 코드 : \(statusCode)")
                }

            }
            .store(in: &cancellables)
    }
    
    /// 게시물 좋아요 개수 불러오기 메서드
    func getLike(contentId: Int) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/liked/" + String(contentId)) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0
            }
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] (data, response) in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                print("좋아요 불러오기 StatusCode == \(statusCode)")
                let stringInt = String(decoding: data, as: UTF8.self)
                print("-----> 리턴 벨류 \(stringInt)")
                self?.likeCount = stringInt
            }
            .store(in: &cancellables)
    }
    
    /// 게시물 좋아요 동작 메서드
    func likeContent(data: PosterLikeModel, contentNum: Int) {
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/api/facility/content/liked", data: upLoadData, ip: NM.facilityIp)
        } catch(let error) {
            print("error: \(error)")
            return
        }
        
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0
            }
            .sink { completion in
                print(completion)
            } receiveValue: {(data, response) in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                print("댓글 등록 statusCode == \(statusCode)")
                if statusCode == 200 {
                    print("게시물 좋아요 성공")
                    self.getLike(contentId: contentNum)
                    self.changeLikeStatus()
                } else {
                    print("게시물 좋아요 실패")
                }
            }
            .store(in: &cancellables)
    }
    
    /// 게시물 좋아요 상태 변경
    private func changeLikeStatus() {
        if content.userLikeBool == 1 {
            content.userLikeBool = 0
        } else {
            content.userLikeBool = 1
        }
    }
    
    // MARK: - 댓글 관련 메서드
    /// 댓글 불러오기 메서드
    func getComment(contentId: Int) {
        guard let url = URL(string: NM.serverAddress + "/facility-service/comment/" + String(contentId)) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(getFacilitiesHandleOutput)
            .decode(type: [CommentModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedValue in
                print("-----> 댓글 값\(returnedValue)")
                self?.comments = returnedValue
            }
            .store(in: &cancellables)
    }
    
    /// 댓글 작성 메서드
    func createComment(contentId: Int, data: CommentRegisterModel) {
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/api/facility/content/comment", data: upLoadData, ip: NM.facilityIp)
        } catch(let error) {
            print("error: \(error)")
            return
        }
        
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0
            }
            .sink { completion in
                print(completion)
            } receiveValue: {(data, response) in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                print("댓글 등록 statusCode == \(statusCode)")
                if statusCode == 200 {
                    print("댓글 등록 성공")
                    self.getComment(contentId: contentId)
                } else {
                    print("댓글 등록 실패")
                }
            }
            .store(in: &cancellables)
    }
    
    /// 댓글 삭제 메서드
    func deleteComment(commentNum: Int, userUUID: String) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/comment/delete/" + String(commentNum) + "/" + userUUID) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0.response
            }
            .sink { completion in
                print(completion)
            } receiveValue: { response in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                if statusCode == 200 {
                    self.getComment(contentId: self.content.contentNum)
                }
                print("-----> 댓글 삭제 statusCode : \(statusCode)")
            }
            .store(in: &cancellables)
    }

    /// 통신 핸들러
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200
        else { throw URLError(.badServerResponse) }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
    
}
