//
//  MyPageView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

struct MyPageView: View {
    
    @StateObject var LoginVM = LoginViewModel.shared
    
    var body: some View {
        if LoginVM.isLoggedIn {
            SignedMyPageView()
                .environmentObject(LoginVM)
        } else {
            LoginView()
                .environmentObject(LoginVM)
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyPageView()
        }
    }
}
