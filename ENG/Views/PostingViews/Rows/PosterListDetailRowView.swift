//
//  PosterListDetailRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/10/14.
//

import SwiftUI

struct PosterListDetailRowView: View {
    
    let contentTitle: String
    let contentText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(contentTitle)
                .font(.custom(Font.theme.mainFontBold, size: 13))

            Text(contentText)
                .font(.custom(Font.theme.mainFont, size: 10))
                .foregroundColor(Color.theme.secondary)
                .lineLimit(1)
                .padding(.trailing)
        }
        .frame(width: 329, height: 58, alignment: .leading)
        .padding(.horizontal)
    }
}

struct PosterListDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        PosterListDetailRowView(contentTitle: "제목", contentText: "내요요요요요요")
    }
}
