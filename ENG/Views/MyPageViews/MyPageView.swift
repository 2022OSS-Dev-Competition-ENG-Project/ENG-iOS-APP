//
//  MyPageView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

struct MyPageView: View {
    
    @State private var loginState: Bool = false
    
    var body: some View {
        if loginState {
            SignedMyPageView()
        } else {
            LoginView()
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
