//
//  FacilityDetailMainView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

struct FacilityDetailMainView: View {
    
    var facilityName: String
    
    var body: some View {
        VStack(spacing: 38) {
            Notice
                .padding(.top, 38)
            
            MainButtons
            
            SafetyCommunicationList
            
            Spacer()
        }
        .navigationTitle(facilityName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FacilityDetailMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FacilityDetailMainView(facilityName: "그래용 시티")
        }
    }
}

extension FacilityDetailMainView {
    private var Notice: some View {
        Image(systemName: "mic.fill.badge.plus")
            .resizable()
            .scaledToFit()
            .frame(width: 360, height: 120, alignment: .center)
            .background(Color.theme.green)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var MainButtons: some View {
        HStack(alignment: .center ,spacing: 28) {
            Button {
                
            } label: {
                Text("위험 분석")
                    .foregroundColor(.black)
                    .frame(width: 166, height: 120, alignment: .center)
                    .background(Color.theme.orange)
                    .cornerRadius(8)
            }
            
            Button {
                
            } label: {
                Text("신고하기")
                    .foregroundColor(.black)
                    .frame(width: 166, height: 120, alignment: .center)
                    .background(Color.theme.orange)
                    .cornerRadius(8)
            }
        }
    }
    
    private var SafetyCommunicationList: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.theme.secondary, lineWidth: 1)
                
            VStack {
                HStack {
                    Text("안전소통 게시판")
                        .font(.custom(Font.theme.mainFontBold, size: 16))
                    
                    Spacer()
                    
                    NavigationLink {
                        SafetyListView()
                    } label: {
                        Text("더보기>")
                            .font(.custom(Font.theme.mainFontBold, size: 13))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 13)
                
                // 리스트 불러오기
                RoundedRectangle(cornerRadius: 8)
                    .padding(.horizontal, 16)
            }
        }
        .frame(width: 360, alignment: .center)
        .frame(minHeight: 0, maxHeight: .infinity)
        .padding(.bottom, 15)
    }
}
