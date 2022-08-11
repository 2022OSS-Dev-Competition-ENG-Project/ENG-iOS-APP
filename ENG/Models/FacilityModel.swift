//
//  facilityModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/10.
//

import Foundation

// MARK: Facility List Model
struct Facilities: Codable {
    let count: Int
    let facility_list: [facility]
    
    struct facility: Codable, Identifiable {
        let id: String
        let facility_name: String
        let isLiked: Bool
        
        enum CodingKeys: String, CodingKey {
            case id = "facility_id"
            case facility_name
            case isLiked
        }
        
        init(id: String = UUID().uuidString, facility_name: String, isLiked: Bool = false) {
            self.id = id
            self.facility_name = facility_name
            self.isLiked = isLiked
        }
    }
    

}
