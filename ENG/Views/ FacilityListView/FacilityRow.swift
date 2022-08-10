//
//  FacilityRow.swift
//  ENG
//
//  Created by 정승균 on 2022/08/10.
//

import SwiftUI

struct FacilityRow: View {
    
    let item: Facilities.facility
    @State private var isLiked: Bool = true
    
    var body: some View {
        HStack {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .foregroundColor(.theme.red)
                .padding(.leading)
                .frame(width: 35, height: 32)
                .onTapGesture {
                    // Model의 값 수정 필요
                    isLiked = !isLiked
                }
                
        
            Text(item.facility_name)
                .font(.custom("Apple SD Gothic Neo Bold", size: 24))
                .fontWeight(.bold)
            Spacer()
        }
        .frame(width: 288, height: 60, alignment: .center)

    }
}

struct FacilityRow_Previews: PreviewProvider {
    static var previews: some View {
        FacilityRow(item: Facilities.facility(id: "1", facility_name: "메레용시티"))
            .previewLayout(.sizeThatFits)
    }
}
