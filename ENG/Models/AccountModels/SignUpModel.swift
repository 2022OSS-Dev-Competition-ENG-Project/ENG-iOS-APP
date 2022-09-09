//
//  SignUpModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/23.
//

import Foundation

struct SignUpModel: Codable {
    let userEmail: String
    let userPassword: String
    let userName: String
    let userNickname: String
    let userPhoneNum: String
}
