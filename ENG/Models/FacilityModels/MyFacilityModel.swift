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
         "facilityNum": "98097998-95f6-4a04-9ab6-d71b672e2782",
         "facilityName": "대구가톨릭대학교"
         "likeBool": 1
     },
     {
         "facilityNum": "b31a1bfc-80de-41c6-bcaa-a08567c230d8",
         "facilityName": "하양 한울타리"
         "likeBool": 1
     }
 ]
*/

struct MyFacilityModel: Codable, Identifiable {
    let id: String
    let facilityName: String
    var likeBool: Int
    
    var isLikedBool: Bool {
        if self.likeBool == 0 {
            return false
        }
        else {
            return true
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "facilityNum"
        case facilityName, likeBool
    }
}
