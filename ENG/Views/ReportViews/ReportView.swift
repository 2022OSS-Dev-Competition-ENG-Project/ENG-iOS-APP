//
//  ReportView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/18.
//

import SwiftUI

// MARK: - MainViewStruct
struct ReportView: View {
    
    @StateObject var VM = ReportRegisterViewModel()
    
    let facilityId: String
    
    /// Image Picker 제어 프로퍼티
    @State var showImagePicker: Bool = false
    /// 이미지 미리보기 저장 뷰
    @State var image: [Image?] = [nil, nil, nil]
    
    // 신고 정보 저장 프로퍼티
    @State var reportTitleTextField: String = ""
    @State var reportType: String = ""
    @State var reportContentTextField: String = ""
    @State var placeHolderTextField: String = "글 내용을 입력하세요. (500자 이내)"
    
    // FocusState 변수
    @FocusState var reportContentTextFieldFocused: Bool
    
    /// 업로드할 이미지 저장 프로퍼티
    @State var uploadImages: [UIImage] = []
    
    // NavigationView Dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 19) {
            titleInputView
            
            reportTypeInputView
 
            uploadImageButton
            
            imagePreview
            
            reportContentInputView
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert("등록 성공", isPresented: $VM.isReportSuccess, actions: {
            Button("확인") {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        // Navigation View 관련 설정
        .navigationTitle("신고하기")
        .navigationBarTitleDisplayMode(.inline)
        // 신고 등록 버튼
        .navigationBarItems(trailing: Button(action: {
            guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
            VM.reportRegister(inputData: ReportRegisterModel(reportTitle: self.reportTitleTextField, reportText: self.reportContentTextField, reportType: self.reportType, userUuid: userUUID, facilityNo: self.facilityId), images: self.uploadImages)
        }, label: {
            Text("등록")
                .font(.custom(Font.theme.mainFontBold, size: 16))
        }))
    }
}

extension ReportView {
    /// 제목 입력 뷰
    private var titleInputView: some View {
        TextField("제목을 입력해주세요.", text: $reportTitleTextField)
            .customTextField(padding: 15)
            .padding(.horizontal, 16)
            .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
        
    }
    
    /// 사진 선택 뷰
    private var reportTypeInputView: some View {
        ZStack {
            TextField("신고 종류를 선택해주세요.", text: $reportType)
                .customTextField(padding: 15)
                .disabled(true)
                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 0)
                .padding(.horizontal, 16)
            Menu {
                // 신고 타입 회의 필요
                Button("누수 신고", action: { reportType = "누수 신고" })
                Button("외벽 균열 신고", action: { reportType = "외벽 균열 신고" })
                Button("전기 설비 이상 신고", action: { reportType = "전기 설비 이상 신고" })
                Button("소화 설비 이상 신고", action: { reportType = "소화 설비 이상 신고" })
                Button("기타", action: { reportType = "기타" })
            } label: {
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.black)
                    .frame(width: 12, height: 12, alignment: .center)
            }
            .frame(width: UIScreen.main.bounds.width - 32, alignment: .trailing)
            .padding(.trailing, 30)
        }
    }
    
    /// 사진 선택 버튼
    private var uploadImageButton: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showImagePicker.toggle()
            }) {
                Text("이미지 업로드")
            }
            .padding(.trailing)
        }
    }
    
    /// 이미지 미리보기 뷰
    private var imagePreview: some View {
        HStack(spacing: 44) {
            
            ForEach(0..<3) { index in
                ZStack(alignment: .topTrailing) {
                    image[index]?
                        .resizable()
                        .frame(width: 90, alignment: .center)
                        .overlay(Rectangle()
                            .fill(Color.black.opacity(0.25))
                        )
                    
                    Button {
                        // 이미지 삭제
                        image[index] = nil
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .padding(.all, 5)
                            .foregroundColor(.white)
                            .opacity(image[index] != nil ? 1 : 0)
                    }

                }
                .frame(width: 90, height: 90, alignment: .center)
                .border(.black, width: 1)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 90, alignment: .center)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                if self.image[0] == nil {
                    self.image[0] = Image(uiImage: image)
                    self.uploadImages.append(image)
                }
                else if self.image[1] == nil {
                    self.image[1] = Image(uiImage: image)
                    self.uploadImages.append(image)
                }
                else {
                    self.image[2] = Image(uiImage: image)
                    self.uploadImages.append(image)
                }
                
            }
        }
        
    }
    
    /// 신고 내용 입력 뷰
    private var reportContentInputView:some View {
        ZStack {
            if reportContentTextField.isEmpty {
                TextEditor(text: $placeHolderTextField)
                    .padding(.all, 16)
                    .foregroundColor(Color.theme.secondary)
                    .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
                    .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .disabled(true)
                    .customTextField(padding: 0)
            }
            TextEditor(text: $reportContentTextField)
                .padding(.all, 16)
                .foregroundColor(Color.black)
                .lineSpacing(5)
                .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
                .frame(minHeight: 0, maxHeight: .infinity, alignment: .center)
                .customTextField(padding: 0)
                .opacity(reportContentTextFieldFocused || !reportContentTextField.isEmpty ? 1 : 0.1)
                .focused($reportContentTextFieldFocused)
        }
    }
}

// MARK: - Functions
extension ReportView {
    /// 백그라운드 터치시 키보드 숨김
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Preview
struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportView(facilityId: "")
        }
    }
}
