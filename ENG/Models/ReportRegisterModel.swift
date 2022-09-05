//
//  ReportRegisterModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/05.
//

import Foundation

// REQUEST DATA
/*
 JSON :
 {
     "reportTitle" : "0905(월).",
     "reportText" :"기능 테스트",
     "reportType" : "범죄",
     "userUuid" : "0f797583-f9dd-4ec3-bb59-39d4cf862ed1",
     "facilityNo" :"247f9839-53a4-426c-994d-878f1c05d47b"
 }
*/
struct ReportRegisterModel: Codable {
    let reportTitle: String
    let reportText: String
    let reportType: String
    let userUuid: String
    let facilityNo: String
}
