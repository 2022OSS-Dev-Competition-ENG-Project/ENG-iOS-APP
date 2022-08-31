//
//  ContentDetailModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation



struct ContentDetailModel: Codable {
    let contentNum: Int
    let contentTitle: String
    let contentText: String
    let contentDate: String
    let contentLook: String
    let userNickName: String
    
    var contentViewDate: String {
        var date: String = self.contentDate
        do {
            date.remove(at: try date.getIndex(at: 10))
            date.insert(" ", at: try date.getIndex(at: 10))

            date = date.replacingOccurrences(of: "-", with: "/")
            date.removeSubrange(try date.getIndex(at: 16)..<date.endIndex)
        } catch {
            print(error)
        }
        return date
    }
}

// 댓글 모델
/*
 [
     {
         "commentNum": 1,
         "commentText": "너무 힘들어요 살려주세요",
         "commentDate": "2022-08-31T00:00:00",
         "userNickName": "CheolSuJjang"
     },
     {
         "commentNum": 2,
         "commentText": "너무 힘들어요 살려주세요",
         "commentDate": "2022-08-31T00:00:00",
         "userNickName": "18최보현"
     },
     {
         "commentNum": 3,
         "commentText": "너무 힘들어요 살려주세요",
         "commentDate": "2022-08-31T00:00:00",
         "userNickName": "18최보현"
     },
     {
         "commentNum": 4,
         "commentText": "너무 힘들어요 살려주세요",
         "commentDate": "2022-08-31T00:00:00",
         "userNickName": "18최보현"
     }
 ]
*/

struct CommentModel: Codable, Identifiable {
    let id: Int
    let commentText: String
    let commentDate: String
    let userNickName: String
    let userUuid: String
    
    var commentViewDate: String {
        var date: String = self.commentDate
        do {
            date.remove(at: try date.getIndex(at: 10))
            date.insert(" ", at: try date.getIndex(at: 10))

            date = date.replacingOccurrences(of: "-", with: "/")
        } catch {
            print(error)
        }
        return date
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "commentNum"
        case commentText, commentDate, userNickName, userUuid
    }
}

// 댓글 등록 모델
/*
 {
     "commentText" : "너무 힘들어요 살려주세요",
     "contentNum" : "55",
     "userUuid":"0f797583-f9dd-4ec3-bb59-39d4cf862ed1",
     "facilityUuid":"247f9839-53a4-426c-994d-878f1c05d47b"
 }
*/
struct CommentRegisterModel: Codable {
    let commentText: String
    let contentNum: String
    let userUuid: String
}
