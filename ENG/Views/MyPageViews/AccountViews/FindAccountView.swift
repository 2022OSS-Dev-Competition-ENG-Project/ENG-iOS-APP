//
//  FindAccountView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/11.
//

import SwiftUI

struct FindAccountView: View {
    var body: some View {
        ZStack {
            Color(hex: "EBEBEB")
            VStack(spacing: 40) {
                // ID 찾기 버튼
                NavigationLink {
                    FindIDView()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 200, alignment: .center)
                            .background(Color.theme.accent)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80, alignment: .center)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(40)
                            Text("ID 찾기")
                                .foregroundColor(.white)
                                .font(.custom(Font.theme.mainFontBold, size: 30))
                        }
                    }
                }
                
                // 비밀번호 찾기 버튼
                NavigationLink {
                    FindPasswordView()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 200, alignment: .center)
                            .background(Color.theme.accent)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        VStack {
                            Image(systemName: "lock.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80, alignment: .center)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(40)
                            Text("비밀번호 찾기")
                                .foregroundColor(.white)
                                .font(.custom(Font.theme.mainFontBold, size: 30))
                        }
                    }
                }
            }
        }
        .navigationTitle("ID/PW 찾기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FindAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FindAccountView()
        }
    }
}
