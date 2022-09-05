//
//  ContentRegisterViewModel.swift
//  ENG
//
//  Created by 정승균 on 2022/09/05.
//

import Foundation
import Combine

class ContentRegisterViewModel: ObservableObject {
    let NM = NetworkManager.shared
    
    @Published var isRegisterSuccess: Bool = false
    
    func registerContent(inputData: ContentRegisterModel) {
        let boundary = UUID().uuidString
        
        let urlRequest = NM.makeFormDataURLRequest(ipAddress: NM.facilityIp, api: "/api/facility/content/register", boundary: boundary)
        var data = NM.makeStringDataForFormData(boundary: boundary, paramName: "facilityContentDto", inputData: inputData)
        
        // Form-Data의 끝을 알리는 바운더리 append
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        let session = URLSession.shared
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            print("게시물 등록 StatusCode = \(statusCode)")
            if statusCode == 200 {
                print("게시물 등록 성공 !!!!")
                DispatchQueue.main.async {
                    self.isRegisterSuccess = true
                }
            } else {
                print("게시물 등록 실패 error ---->\(String(describing: error))")
            }
        }).resume()
    }
}
