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
    
    @Published var content: ContentDetailModel = ContentDetailModel(contentNum: 0, contentTitle: "", contentText: "", contentDate: "", contentLook: "", userNickName: "")
    @Published var comments: [CommentModel] = []
    @Published var likeCount: String = ""
    
    // get content
    func getContent(userUUID: String, contentId: Int) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/" + String(contentId)) else { return }
        
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
    
    // get like
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
    
    // like content
    func likeContent(data: ContentLikeModel, contentNum: Int) {
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
                } else {
                    print("게시물 좋아요 실패")
                }
            }
            .store(in: &cancellables)
    }
    
    // get Comment
    func getComment(contentId: Int) {
        guard let url = URL(string: NM.facilityIp + "/api/facility/content/comment/" + String(contentId)) else { return }
        
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
    
    // create Comment
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
    
    // delete comment
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

    
    func getFacilitiesHandleOutput(output: Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200
        else { throw URLError(.badServerResponse) }

        print("response.StatusCode == \(response.statusCode), data == \(String(decoding: output.data, as: UTF8.self))")
        
        return output.data
    }
    
}
