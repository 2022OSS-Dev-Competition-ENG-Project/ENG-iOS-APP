//
//  FacilityPosterModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/25.
//

import Foundation

// RESPONSE DATA
/*
 JSON :
    {
         "contentNum": 4,
         "contentTitle": "이미 테스트 입니다. ",
         "contentText": "시간 + ",
         "contentDate": "2022-10-14T00:56:26",
         "contentLook": 1,
         "writerNickName": "abc",
         "writerName": "abc",
         "writerProfileImg": null,
         "writerUuid": "762d0240-93e9-4bf1-8faf-f630fc980a73",
         "userLikeBool": null
     }
*/

struct FacilityPosterModel: Codable, Identifiable {
    let id: Int
    let contentTitle: String
    let contentText: String
    
    enum CodingKeys: String, CodingKey {
        case id = "contentNum"
        case contentTitle, contentText
    }
}

/*
 {
    "contentNum": 139,
    "contentTitle": "나는 승2균이야 ",
    "contentText": " ㄴㄴ ",
    "contentImg": null
 }
*/
struct FacilityNoticeModel: Codable, Identifiable {
    let id: Int
    let contentTitle: String
    let contentImg: String
    
    enum CodingKeys: String, CodingKey {
        case id = "contentNum"
        case contentTitle, contentImg
    }
}
