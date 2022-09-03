//
//  ENGApp.swift
//  ENG
//
//  Created by 정승균 on 2022/08/09.
//

import SwiftUI

@main
struct ENGApp: App {
    
    @State private var tabSelection: Int = 0
    
    var body: some Scene {
        WindowGroup {
            // main에서 TabView로 묶어서 표현
            TabView(selection: $tabSelection) {
                NavigationView {
                    FacilityView(tabSelection: $tabSelection)

                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "building")
                        .foregroundColor(Color.theme.sub)
                    Text("시설")
                }
                .tag(0)
                NavigationView {
                    MyPageView()
                }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color.theme.sub)
                    Text("마이페이지")
                }
                .tag(1)
            }
            
        }
    }
}
