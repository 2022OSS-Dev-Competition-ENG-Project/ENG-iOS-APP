//
//  PostingFieldModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/01.
//

import Foundation

// 게시물 등록
// REQUEST DATA
/*
 JSON :
 {
     "contentTitle" : "이미 테스트 입니다. ",
     "contentText" : "시간 + ",
     "contentLook" : 100,
     "contentType" : 0,
     "facilityNo" : "247f9839-53a4-426c-994d-878f1c05d47b",
     "userUuid" : "0f797583-f9dd-4ec3-bb59-39d4cf862ed1"
 }
*/
struct PostingFieldModel: Codable {
    let contentTitle: String
    let contentText: String
    let contentLook: Int
    let contentType: Int
    let facilityNo: String
    let userUuid: String
}
