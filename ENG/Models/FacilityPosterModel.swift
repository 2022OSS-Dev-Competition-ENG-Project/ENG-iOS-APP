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
 [
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
     },
     {
         "facilityContentNum": 10,
         "facilityContentTitle": "디투 부서지고있어요",
         "facilityContentText": "슬퍼요",
         "facilityContentImg": "/dir/dir/water",
         "facilityContentDate": null,
         "facilityContentLook": 100,
         "facilityContentType": 0,
         "facilityNo": "5e541bc2-a7ef-4513-8f5e-447b0e07411e",
         "userUuid": "a9babfe7-c58c-4705-9c87-80d1733b4008"
     },
     {
         "facilityContentNum": 11,
         "facilityContentTitle": "잘들 지내시나요",
         "facilityContentText": "저는 잘 지내요",
         "facilityContentImg": "/dir/dir/water",
         "facilityContentDate": null,
         "facilityContentLook": 100,
         "facilityContentType": 0,
         "facilityNo": "5e541bc2-a7ef-4513-8f5e-447b0e07411e",
         "userUuid": "a9babfe7-c58c-4705-9c87-80d1733b4008"
     },
     {
         "facilityContentNum": 12,
         "facilityContentTitle": "화가나요",
         "facilityContentText": "정훈이가 괴롭혀요",
         "facilityContentImg": "/dir/dir/water",
         "facilityContentDate": null,
         "facilityContentLook": 100,
         "facilityContentType": 0,
         "facilityNo": "5e541bc2-a7ef-4513-8f5e-447b0e07411e",
         "userUuid": "a9babfe7-c58c-4705-9c87-80d1733b4008"
     },
     {
         "facilityContentNum": 13,
         "facilityContentTitle": "기능 구현이 시급해요",
         "facilityContentText": "너무 너무 바빠요",
         "facilityContentImg": "/dir/dir/water",
         "facilityContentDate": null,
         "facilityContentLook": 990,
         "facilityContentType": 0,
         "facilityNo": "5e541bc2-a7ef-4513-8f5e-447b0e07411e",
         "userUuid": "a9babfe7-c58c-4705-9c87-80d1733b4008"
     }
 ]
*/

struct FacilityPosterModel: Codable, Identifiable {
    let id: Int
    let facilityContentTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id = "facilityContentNum"
        case facilityContentTitle
    }
}
