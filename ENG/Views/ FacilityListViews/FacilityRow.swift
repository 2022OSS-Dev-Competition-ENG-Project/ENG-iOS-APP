//
//  FacilityRow.swift
//  ENG
//
//  Created by 정승균 on 2022/08/10.
//

import SwiftUI

struct FacilityRow: View {
    
    let item: MyFacilityModel
    @State var isLiked: Bool
    @EnvironmentObject var VM: MyFaciltyViewModel
    
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
                    VM.likeFaiclity(userUUID: UserDefaults.standard.string(forKey: "loginToken") ?? "", faclityUUID: item.id)
                    isLiked = !isLiked
                }
                
        
            Text(item.facilityName)
                .font(.custom(Font.theme.mainFontBold, size: 24))
                .fontWeight(.bold)
            Spacer()
        }
        .frame(width: 288, height: 60, alignment: .center)

    }
}

struct FacilityRow_Previews: PreviewProvider {
    static var previews: some View {
        FacilityRow(item: MyFacilityModel(userUuid: "asdf", facilityAddress: "어디어디 하양", id: "facility num", facilityName: "이정훈 시설물", isLiked: 0), isLiked: true)
            .previewLayout(.sizeThatFits)
            .environmentObject(MyFaciltyViewModel())
    }
}
