//
//  MyPageUserInfoModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/31.
//

import Foundation

struct MyPageUserInfoModel: Codable {
    let userEmail: String
    let userNickname: String
    let userJoinDate: String
    let userImg: String
    
    var userJoinViewDate: String {
        var date: String = self.userJoinDate
            date = date.replacingOccurrences(of: "-", with: ".")
        return date
    }
}
