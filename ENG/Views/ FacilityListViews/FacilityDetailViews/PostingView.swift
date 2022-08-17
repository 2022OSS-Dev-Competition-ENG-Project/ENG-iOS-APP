//
//  PostingView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

struct PostingView: View {
    
    @State var postTitleTextField: String = ""
    @State var postContentTextField: String = ""
    @State var placeHolderText: String = "글 내용을 입력하세요. (500자 이내)"
    @FocusState private var contentTextFieldIsFocused: Bool // 포커스 상태 변수
    
    var body: some View {
        VStack {
            TextField("글 제목을 입력하세요.", text: $postTitleTextField)
                .customTextField(padding: 13)
                .padding(.horizontal, 16)
                .padding(.vertical, 30)
            ZStack {
                if postContentTextField.isEmpty {
                    TextEditor(text: $placeHolderText)
                        .padding(.all, 16)
                        .foregroundColor(Color.theme.secondary)
                        .lineSpacing(5)
                        .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
                        .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .disabled(true)
                        .customTextField(padding: 0)
                }
                TextEditor(text: $postContentTextField)
                    .padding(.all, 16)
                    .foregroundColor(Color.black)
                    .lineSpacing(5)
                    .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
                    .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .customTextField(padding: 0)
                    .opacity(contentTextFieldIsFocused ? 1 : 0.1)
                    .focused($contentTextFieldIsFocused)
            }
        }
        .navigationTitle("글쓰기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("등록", action: post))
    }
    
    private func post() {
        print("등록 완")
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostingView()
        }
    }
}
