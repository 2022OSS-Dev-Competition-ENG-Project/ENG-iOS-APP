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
    
    init() {
        self.allFacilityList.append(Facilities.facility(id: "1", facility_name: "크레용시티"))
        self.allFacilityList.append(Facilities.facility(id: "2", facility_name: "마그마시티"))
        self.allFacilityList.append(Facilities.facility(id: "3", facility_name: "대구가톨릭대학교"))
    }
    
    
}
