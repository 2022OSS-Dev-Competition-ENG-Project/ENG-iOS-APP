//
//  MyPageModel.swift
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

// 내가 등록한 게시물 리스트
/*
 JSON :
 {
     "contentNum": 154,
     "contentTitle": "점검 3",
     "contentText": " 점검 3",
     "contentDate": "2022-09-02T22:15:40"
 }
*/

struct MainMyContent: Codable, Identifiable {
    let id: Int
    let contentTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id = "contentNum"
        case contentTitle
    }
}

/*
 {
     "reportNum": 29,
     "reportTitle": "신고중입니다.",
     "reportText": "손2들3어 꼼짝마",
     "reportType": "범죄",
     "reportDate": "2022-09-04T08:20:26",
     "reportImg": "http://localhost:2200/api/facility/content/image/view/Users&jeonghunlee&image&content&247f9839-53a4-426c-994d-878f1c05d47b&29&짱구야 놀자.png ",
     "reportStatus": "해결",
     "userUuid": "0f797583-f9dd-4ec3-bb59-39d4cf862ed1",
     "facilityNo": "247f9839-53a4-426c-994d-878f1c05d47b"
 }
*/

struct MainMyReport: Codable, Identifiable {
    let id: Int
    let reportTitle: String
    let reportStatus: String
    
    enum CodingKeys: String, CodingKey {
        case id = "reportNum"
        case reportTitle, reportStatus
    }
}
