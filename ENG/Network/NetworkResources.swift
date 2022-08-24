//
//  NetworkResources.swift
//  ENG
//
//  Created by 정승균 on 2022/08/24.
//

import Foundation

class NetworkManager {
    
    // NetworkManager를 싱클톤 패턴으로 운용
    static let shared = {
        return NetworkManager()
    }()
    
    private init() {
        
    }
    
    let facilityIp: String = "http://203.250.32.29:2200"
    let userIp: String = "http://203.250.32.29:2201"

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

}
