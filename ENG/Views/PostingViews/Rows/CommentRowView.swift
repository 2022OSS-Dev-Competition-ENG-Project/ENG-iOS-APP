//
//  CommentRowView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI
import Combine

// MARK: - MainViewStruct
struct CommentRowView: View {
    @EnvironmentObject var VM: PosterDetailViewModel
    
    let commentNum: Int
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
                    VM.deleteComment(commentNum: self.commentNum, userUUID: self.userUUID)
                } label: {
                    Text("삭제")
                        .font(.custom(Font.theme.mainFont, size: 16))
                        .hideToBool(userUUID != UserDefaults.standard.string(forKey: "loginToken")!)
                }
                .foregroundColor(.theme.accent)
            }
            
            Text(commentText)
        }
        .frame(minHeight: 50, maxHeight: 100)
    }
    
}

// MARK: - Preview
struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(commentNum: 5, nickName: "김철수", commentText: "바보", commentDate: "2018-12-29 10:24:30", userUUID: "ㄹ")
            .previewLayout(.sizeThatFits)
            .environmentObject(PosterDetailViewModel())
    }
}
