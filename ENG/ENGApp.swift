//
//  ENGApp.swift
//  ENG
//
//  Created by 정승균 on 2022/08/09.
//

import SwiftUI

@main
struct ENGApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    FacilityView()
                }
                .tabItem {
                    Image(systemName: "building")
                    Text("시설")
                }
                NavigationView {
                    Text("마이페이지")
                }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("마이페이지")
                }
            }
            
        }
    }
}
