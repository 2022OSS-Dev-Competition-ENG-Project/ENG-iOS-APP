//
//  ENGApp.swift
//  ENG
//
//  Created by 정승균 on 2022/08/09.
//

import SwiftUI

@main
struct ENGApp: App {
    
    @StateObject private var facilityVM = FacilityListViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            // main에서 TabView로 묶어서 표현
            TabView {
                NavigationView {
                    FacilityView()
                }
                .environmentObject(facilityVM)
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "building")
                        .foregroundColor(Color.theme.sub)
                    Text("시설")
                }
                NavigationView {
                    MyPageView()
                }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color.theme.sub)
                    Text("마이페이지")
                }
            }
            
        }
    }
}
