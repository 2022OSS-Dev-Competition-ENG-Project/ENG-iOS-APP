//
//  FacilityResgistrationModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation

// REQUEST DATA
/*
    {
     "userUuid" : "a9babfe7-c58c-4705-9c87-80d1733b4008",
     "userFacility" : "f11788ce-01af-46d0-9cdd-9aa3e62d2c93"
    }
*/

struct FacilityResgistrationModel: Codable {
    let userUuid: String
    let userFacility: String
}
