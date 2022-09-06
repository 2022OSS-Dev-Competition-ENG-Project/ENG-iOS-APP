//
//  NetworkResources.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation
import UIKit

class NetworkManager {
    
    // NetworkManager를 싱클톤 패턴으로 운용
    static let shared = {
        return NetworkManager()
    }()
    
    private init() {
        
    }
    
    let facilityIp: String = "http://203.250.32.29:2200"
    let userIp: String = "http://203.250.32.29:2201"
    let AIIp: String = "http://203.250.32.29:2222"
    
    // Post용 URL Request 생성 메서드
    func makePostRequest(api: String, data: Data = Data(), ip: String) throws -> URLRequest {
        guard let url = URL(string: ip + api) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        
        return urlRequest
    }
    
    // Form-Data용 URL Request 생성 메서드
    func makeFormDataURLRequest(ipAddress: String, api: String, boundary: String) -> URLRequest {
        let url = URL(string: ipAddress + api)
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    // Form-Data용 이미지 데이터 생성 메서드
    func makeImageDataForFormData(paramName: String, images: [UIImage], boundary: String) -> Data {
        var data = Data()
        
        for (index, image) in images.enumerated() {
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(index + 1).png\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)
        }
        
        return data
    }
    
    // Form-Data용 JSON 데이터 생성 메서드
    func makeJSONDataForFormData<T: Codable>(boundary: String, paramName: String, inputData: T) -> Data {
        var data = Data()
        
        let jsonData = try! JSONEncoder().encode(inputData)

        let stringData = String(decoding: jsonData, as: UTF8.self)
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\";\r\n".data(using: .utf8)!)
        data.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
        data.append(stringData.data(using: .utf8)!)
        
        return data
    }
    
    func makeStringDataForFormData(boundary: String, paramName: String, inputData: String) -> Data {
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\";\r\n".data(using: .utf8)!)
        data.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        data.append(inputData.data(using: .utf8)!)
        
        return data
    }
}
