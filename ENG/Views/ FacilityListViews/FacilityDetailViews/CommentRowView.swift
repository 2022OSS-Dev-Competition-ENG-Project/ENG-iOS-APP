//
//  CommentRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

struct CommentRowView: View {
    var body: some View {
        VStack {
            HStack {
                Text("댓글 1")
                    .font(.custom(Font.theme.mainFontBold, size: 16))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("수정")
                        .font(.custom(Font.theme.mainFont, size: 16))
                }
                .foregroundColor(.theme.accent)
            }
            .padding(.bottom, 4)
            
            Text("내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용")
        }
        .frame(minHeight: 0, maxHeight: 100)
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView()
            .previewLayout(.sizeThatFits)
    }
}
