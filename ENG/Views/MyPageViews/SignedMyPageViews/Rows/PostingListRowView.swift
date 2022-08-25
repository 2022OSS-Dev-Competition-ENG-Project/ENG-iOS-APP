//
//  PostingListRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/16.
//

import SwiftUI

struct PostingListRowView: View {
    
    var postingNumber = 1
    var postingTitle: String = ""
    
    var body: some View {
        HStack {
            Text(postingNumber.asListNumberString())
            Text(postingTitle)
            
            Spacer()
        }
        .font(.custom(Font.theme.mainFont, size: 14))
        .frame(width: 327, height: 20, alignment: .center)
    }
}

struct PostingListRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostingListRowView()
                .previewLayout(.sizeThatFits)
            PostingListRowView(postingNumber: 2)
                .previewLayout(.sizeThatFits)
        }
    }
}
