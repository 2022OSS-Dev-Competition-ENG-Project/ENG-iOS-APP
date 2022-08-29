//
//  ResetPWModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/26.
//

import Foundation
// REQUSET DATA
/*
    {
     "userEmail" : "test@naver.com",
     "userName" : "최보현"
    }
 */

struct ResetPWRequestModel: Codable {
    let userEmail: String
    let userName: String
}
