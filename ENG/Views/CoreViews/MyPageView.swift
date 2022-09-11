//
//  MyPageView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

// MARK: - MainViewStruct
struct MyPageView: View {
    
    @StateObject var LoginVM = LoginViewModel.shared
    
    var body: some View {
        if LoginVM.isLoggedIn {
            MyProfileView()
                .environmentObject(LoginVM)
        } else {
            LoginView()
                .environmentObject(LoginVM)
        }
    }
}

// MARK: - Preview
struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyPageView()
        }
    }
}
