//
//  MyContentListModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/04.
//

import Foundation

/*
 {
     "contentNum": 59,
     "contentTitle": "0831일 ",
     "contentText": "잠들다 나는 젭알 그만",
     "contentDate": "2022-08-31T21:20:11"
 }
*/

struct MyContentListModel: Codable, Identifiable {
    let id: Int
    let contentTitle: String
    let contentText: String
    
    enum CodingKeys: String, CodingKey {
        case id = "contentNum"
        case contentTitle, contentText
    }
}
