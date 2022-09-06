//
//  RiskAnalysisView.swift
//  ENG
//
//  Created by 정승균 on 2022/09/06.
//

import SwiftUI

struct RiskAnalysisView: View {
    
    @StateObject var VM = RiskAnalysisViewModel()
    
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    @State var uploadImage: [UIImage] = []
    
    var body: some View {
        VStack {
            Button {
                self.showImagePicker.toggle()
            } label: {
                if image == nil {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .foregroundColor(.black)
                } else {
                    image?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .foregroundColor(.black)
                }
               
                
            }
            ZStack {
                Text("분석할 이미지를 선택하세요!")
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                    .hideToBool(image != nil)
                
                Button {
                    VM.doRiskAnalysis(images: self.uploadImage)
                } label: {
                    Text("이미지 분석하기!")
                        .frame(width: 288, height: 40, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.theme.accent)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        .hideToBool(image == nil)
                }
            }
            .padding(.bottom, 50)
            
            
            Group {
                Text("분석 결과")
                    .fontWeight(.bold)
                    .font(.headline)
                Text("해당 이미지의 분석 결과 위험도는 \"\(VM.riskLevel.rawValue)\"입니다.")
            }
            .hideToBool(!VM.isAnalysisSuccess)
            
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.image = Image(uiImage: image)
                uploadImage = [image]
            }
        }
        .navigationTitle("위험 분석")
    }
}

struct RiskAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RiskAnalysisView()
        }
    }
}
