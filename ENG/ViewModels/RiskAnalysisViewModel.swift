//
//  RiskAnalysisViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/06.
//

import Foundation
import UIKit

class RiskAnalysisViewModel: ObservableObject {
    let NM = NetworkManager.shared
    
    @Published var isAnalysisSuccess: Bool = false
    @Published var riskLevel: riskLevel = .noRisk
    
    func doRiskAnalysis(images: [UIImage]) {
        guard let userUUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        let boundary = UUID().uuidString
        
        // urlRequest 생성
        let urlRequest = NM.makeFormDataURLRequest(ipAddress: NM.AIIp, api: "/api/ai/leakPredict", boundary: boundary)
        
        // JSON 데이터 생성
        var data = NM.makeStringDataForFormData(boundary: boundary, paramName: "uuid", inputData: userUUID)
        
        // 이미지 데이터와 JSON 데이터 결합
        let imageData = NM.makeImageDataForFormData(paramName: "file", images: images, boundary: boundary)
        data.append(imageData)
        
        // Form-Data의 끝을 알리는 바운더리 append
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        let session = URLSession.shared
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            print("위험분석 StatusCode = \(statusCode)")
            if statusCode == 200 {
                print("위험분석 성공!!!!")
                guard let riskLevel = responseData else { return }
                print("위험 레벨 ----> \(String(decoding: riskLevel, as: UTF8.self))")
                DispatchQueue.main.async {
                    self.isAnalysisSuccess = true
                    let riskString = String(decoding: riskLevel, as: UTF8.self)
                    
                    switch riskString {
                    case "3" :
                        self.riskLevel = .high
                    case "2" :
                        self.riskLevel = .mid
                    case "1" :
                        self.riskLevel = .low
                    default :
                        self.riskLevel = .noRisk
                    }
                    
                }
            } else {
                print("위험 분석 실패 error ---->\(String(describing: error))")
            }
        }).resume()
    }
    
    enum riskLevel: String {
        case high = "상"
        case mid = "중"
        case low = "하"
        case noRisk = "위험요소 없음"
    }
}
