//
//  ContentDetailModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import Foundation



struct ContentDetailModel: Codable {
    let contentNum: Int
    let contentTitle: String
    let contentText: String
    let contentDate: String
    let contentLook: String
    let userNickName: String
}
