//
//  PostingFieldView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

// MARK: - MainViewStruct
struct PostingFieldView: View {
    
    let facilityId: String
    
    @State var postTitleTextField: String = ""
    @State var postContentTextField: String = ""
    @State var placeHolderText: String = "글 내용을 입력하세요. (500자 이내)"
    @FocusState private var contentTextFieldIsFocused: Bool // 포커스 상태 변수
    
    @StateObject var VM = PostingFieldViewModel()
    
    // NavigationView Dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                    .opacity(contentTextFieldIsFocused || !postContentTextField.isEmpty ? 1 : 0.1)
                    .focused($contentTextFieldIsFocused)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert("등록 성공!", isPresented: $VM.isRegisterSuccess, actions: {
            Button("확인") {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .navigationTitle("글쓰기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("등록", action: post))
    }
    

}

// MARK: - Functions
extension PostingFieldView {
    /// 게시물 등록 메서드
    private func post() {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        // 등록 기능 구현
        VM.registerContent(inputData: PostingFieldModel(contentTitle: postTitleTextField, contentText: postContentTextField, facilityNum: self.facilityId, userUuid: userUUID))
    }
    
    /// 백그라운드 터치 시 키보드 내림
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct PostingFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostingFieldView(facilityId: "")
        }
    }
}
