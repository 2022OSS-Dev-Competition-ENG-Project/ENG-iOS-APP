//
//  ReportRegisterViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/05.
//

import Foundation
import UIKit

class ReportRegisterViewModel: ObservableObject {
    let NM = NetworkManager.shared
    
    @Published var isReportSuccess: Bool = false
    
    func reportRegister(inputData: ReportRegisterModel, images: [UIImage]) {
        let boundary = UUID().uuidString
        
        // urlRequest 생성
        let urlRequest = NM.makeFormDataURLRequest(ipAddress: NM.facilityIp, api: "/api/report/register", boundary: boundary)
        
        // JSON 데이터 생성
        var data = NM.makeJSONDataForFormData(boundary: boundary, paramName: "reportDto", inputData: inputData)
        
        // 이미지 데이터와 JSON 데이터 결합
        let imageData = NM.makeImageDataForFormData(paramName: "files", images: images, boundary: boundary)
        data.append(imageData)
        
        // Form-Data의 끝을 알리는 바운더리 append
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        let session = URLSession.shared
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            print("신고하기 StatusCode = \(statusCode)")
            if statusCode == 200 {
                print("신고하기 성공!!!!")
                DispatchQueue.main.async {
                    self.isReportSuccess = true
                }
            } else {
                print("이미지 전송 실패 error ---->\(String(describing: error))")
            }
        }).resume()
    }
}
