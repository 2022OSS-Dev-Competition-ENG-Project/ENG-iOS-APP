//
//  FacilityViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/08/10.
//

import Foundation
import Combine

class FacilityListViewModel: ObservableObject {
    
    @Published var allFacilityList: [Facilities.facility] = []
    @Published var likdeFacilities: [Facilities.facility] = []
    
    init() {
        self.allFacilityList.append(Facilities.facility(id: "1", facility_name: "크레용시티", isLiked: true))
        self.allFacilityList.append(Facilities.facility(id: "2", facility_name: "마그마시티"))
        self.allFacilityList.append(Facilities.facility(id: "3", facility_name: "대구가톨릭대학교"))
        
        self.likdeFacilities = likedFacilty
    }
    
    var likedFacilty: [Facilities.facility] {
        let likedList = allFacilityList.filter { $0.isLiked == true }
        return likedList
    }
    
    func deleteFacility(indexSet: IndexSet) {
        print("지우기")
        print("--=---> \(indexSet)")
        allFacilityList.remove(atOffsets: indexSet)
    }
    
}
