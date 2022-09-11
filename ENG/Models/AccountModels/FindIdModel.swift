//
//  FindIdModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/25.
//

import Foundation

// REQUEST DATA
/*
    {
     "userName" : "최보현",
     "userPhoneNumber" : "01011112222"
    }
*/

struct FindIdModel: Codable {
    let userName: String
    let userPhoneNumber: String
}
