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
         "facilityContentNum": 9,
         "facilityContentTitle": "홍수났어요",
         "facilityContentText": "계속 물이 나와요",
         "facilityContentImg": "/dir/dir/water",
         "facilityContentDate": null,
         "facilityContentLook": 100,
         "facilityContentType": 0,
         "facilityNo": "5e541bc2-a7ef-4513-8f5e-447b0e07411e",
         "userUuid": "a9babfe7-c58c-4705-9c87-80d1733b4008"
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
