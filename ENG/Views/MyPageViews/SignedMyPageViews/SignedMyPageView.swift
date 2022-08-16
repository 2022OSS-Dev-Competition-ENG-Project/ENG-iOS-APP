//
//  SignedMyPageView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct SignedMyPageView: View {
    
    @State private var email: String = "mmmfieife@naver.com"
    
    var body: some View {
        VStack {
            BasicInformation
                .padding(.vertical, 38)
            
            ReportList
                .padding(.bottom, 20)
            
            MyPostingList
            
            Spacer()
        }
        .navigationTitle("마이페이지")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignedMyPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignedMyPageView()
        }
    }
}

extension SignedMyPageView {
    private var BasicInformation: some View {
        HStack(spacing: 30) {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 115, height: 115, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle()
                    .stroke(Color.theme.secondary, lineWidth: 1))
            VStack(alignment: .leading) {
                Text("닉네임")
                    .font(.custom(Font.theme.mainFontBold, size: 24))
                Text(email)
                    .font(.custom(Font.theme.mainFont, size: 16))
                    .foregroundColor(.theme.secondary)
                
                HStack {
                    Text("가입일")
                    Text("20xx.00.00")
                }
                .font(.custom(Font.theme.mainFont, size: 16))
                .foregroundColor(.theme.secondary)

            }
        }
    }
    
    private var ReportList: some View {
        VStack {
            HStack {
                Text("신고 내역")
                    .font(.custom(Font.theme.mainFontBold, size: 20))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("더보기")
                        .font(.custom(Font.theme.mainFont, size: 14))
                        .foregroundColor(.theme.accent)
                }

            }
            .frame(width: 349, alignment: .center)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.theme.secondary, lineWidth: 1)
                    .padding(.horizontal)
                    .frame(height: 153)
                VStack {
                    ReportListRowView(isComplete: true)
                    ReportListRowView(isComplete: false)
                    ReportListRowView(isComplete: true)
                    ReportListRowView(isComplete: false)
                    ReportListRowView(isComplete: true)
                }
            }
        }
    }
    
    private var MyPostingList: some View {
        VStack {
            HStack {
                Text("내가 쓴 글")
                    .font(.custom(Font.theme.mainFontBold, size: 20))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("더보기")
                        .font(.custom(Font.theme.mainFont, size: 14))
                        .foregroundColor(.theme.accent)
                }
            }
            .frame(width: 349, alignment: .center)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.theme.secondary, lineWidth: 1)
                    .padding(.horizontal)
                    .frame(height: 153)
                VStack {
                    PostingListRowView(postingNumber: 1)
                    PostingListRowView(postingNumber: 2)
                    PostingListRowView(postingNumber: 3)
                    PostingListRowView(postingNumber: 4)
                    PostingListRowView(postingNumber: 5)
                }
            }
        }
    }
}
