//
//  SaftyPosterModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation

// JSON :
/*
    [
     {
         "contentNum": 14,
         "contentTitle": "ㅂㄷㅂㄷ",
         "contentText": "죽겠다...",
         "contentImg": null,
         "contentDate": "2022-08-30T00:00:00",
         "userName": "김철수"
     },
     {
         "contentNum": 13,
         "contentTitle": "좀 ",
         "contentText": "죽겠다...",
         "contentImg": null,
         "contentDate": "2022-08-30T00:00:00",
         "userName": "김철수"
     },
    ]
 */

struct SaftyPosterModel: Codable, Identifiable {
    let id: Int
    let contentTitle: String
    let contentText: String
    
    enum CodingKeys: String, CodingKey {
        case id = "contentNum"
        case contentTitle, contentText
    }
}
