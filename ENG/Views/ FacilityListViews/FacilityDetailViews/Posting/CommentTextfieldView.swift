//
//  CommentTextfieldView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/30.
//

import SwiftUI

struct CommentTextfieldView: View {
    @Binding var commentTextField: String
    @Binding var isSend: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                .frame(height: 36)

            HStack {
                TextField("댓글을 입력하세요.", text: $commentTextField)
                    .padding(.horizontal, 32)
                    .disableAutocorrection(true) // 자동 수정 방지 수정자
                    .textInputAutocapitalization(.never)

                Button {
                    isSend = !isSend
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(width: 20, height: 20)
                }
                .padding(.trailing, 30)
            }
        }
    }
}

struct CommentTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextfieldView(commentTextField: .constant(""), isSend: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
