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
    func makeImageDataForFormData(paramName: String, fileName: String, images: [UIImage], boundary: String) -> Data {
        var data = Data()
        
        for image in images {
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)
        }
        
        return data
    }
    
    // Form-Data용 String 데이터 생성 메서드
    func makeStringDataForFormData<T: Codable>(boundary: String, paramName: String, inputData: T) -> Data {
        var data = Data()
        
        let jsonData = try! JSONEncoder().encode(inputData)

        let stringData = String(decoding: jsonData, as: UTF8.self)
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\";\r\n".data(using: .utf8)!)
        data.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        data.append(stringData.data(using: .utf8)!)
        
        return data
    }
    
    // 배열 전송 테스트
    func uploadImages(ipAddress: String, paramName: String, fileName: String, images: [UIImage], userUUID: String, completion: @escaping (Int) -> Void) {
        let url = URL(string: ipAddress + "/api/user-service/SaveProfileImage/" + userUUID)
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()
        
        for image in images {
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)
        }

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            print("이미지 전송 StatusCode = \(statusCode)")
            completion(statusCode)
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }
    
}
