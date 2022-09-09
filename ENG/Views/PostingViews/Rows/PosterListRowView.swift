//
//  PosterListRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct PosterListRowView: View {
    
    var posterNumber = 1
    var posterTitle: String = ""
    
    var body: some View {
        HStack {
            Text(posterNumber.asListNumberString())
                .frame(width: 50)
                .padding(.trailing, 10)
            Text(posterTitle)
            
            Spacer()
        }
        .font(.custom(Font.theme.mainFont, size: 14))
        .frame(width: 327, height: 20, alignment: .center)
    }
}

struct PostingListRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PosterListRowView()
                .previewLayout(.sizeThatFits)
            PosterListRowView(posterNumber: 2)
                .previewLayout(.sizeThatFits)
        }
    }
}
