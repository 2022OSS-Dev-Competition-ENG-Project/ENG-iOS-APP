//
//  CommentRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

struct CommentRowView: View {
    let nickName: String
    let commentText: String
    let commentDate: String
    let userUUID: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(nickName)
                    .font(.custom(Font.theme.mainFontBold, size: 16))
                
                Text(commentDate)
                    .font(.custom(Font.theme.mainFont, fixedSize: 14))
                    .foregroundColor(.theme.secondary)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("수정")
                        .font(.custom(Font.theme.mainFont, size: 16))
                        .opacity(userUUID == UserDefaults.standard.string(forKey: "loginToken")! ? 1 : 0)
                }
                .foregroundColor(.theme.accent)
            }
            
            Text(commentText)
        }
        .frame(minHeight: 50, maxHeight: 100)
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(nickName: "18최보현", commentText: "fasdfasfasfadsfasfasf", commentDate: "YYYY-MM-DDT10:24:30", userUUID: "fasdfasfasf")
            .previewLayout(.sizeThatFits)
    }
}
