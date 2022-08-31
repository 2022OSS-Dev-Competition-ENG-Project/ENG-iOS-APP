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
    
    var contentViewDate: String {
        var date: String = self.contentDate
        do {
            date.remove(at: try date.getIndex(at: 10))
            date.insert(" ", at: try date.getIndex(at: 10))

            date = date.replacingOccurrences(of: "-", with: "/")
            date.removeSubrange(try date.getIndex(at: 16)..<date.endIndex)
        } catch {
            print(error)
        }
        return date
    }
}
