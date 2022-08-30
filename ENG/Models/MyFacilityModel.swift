//
//  MyFacilityModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation
/*
 JSON :
 [
     {
         "userUuid": "343890ca-4bab-4424-9a8d-5f8f90533b77",
         "facilityAddress": "경상북도 경산시 하양읍 하양로 13-13",
         "userFacility": "98097998-95f6-4a04-9ab6-d71b672e2782",
         "facilityName": "대구가톨릭대학교"
         "isLiked": 1
     },
     {
         "userUuid": "343890ca-4bab-4424-9a8d-5f8f90533b77",
         "facilityAddress": "경상북도 경산시 하양읍 대경로 669-5",
         "userFacility": "b31a1bfc-80de-41c6-bcaa-a08567c230d8",
         "facilityName": "하양 한울타리"
         "isLiked": 1
     }
 ]
*/

struct MyFacilityModel: Codable, Identifiable {
    let userUuid: String
    let facilityAddress: String
    let id: String
    let facilityName: String
    var isLiked: Int
    
    var isLikedBool: Bool {
        if self.isLiked == 0 {
            return false
        }
        else {
            return true
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "useFacility"
        case facilityAddress, userUuid, facilityName, isLiked
    }
}
