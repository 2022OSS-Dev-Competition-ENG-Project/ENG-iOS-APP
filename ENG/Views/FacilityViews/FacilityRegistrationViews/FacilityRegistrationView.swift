//
//  FacilityRegistrationView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/18.
//

import SwiftUI
import Combine

// MARK: - MainStructView
struct FacilityRegistrationViews: View {
    
    var NM = NetworkManager.shared
    
    @State private var scannedInfo: String = "//"
    @State private var isQRScanned: Bool = false
    
    private var qrComponents: [String] {
        return scannedInfo.components(separatedBy: "/")
    }
    var body: some View {
        VStack {
                Spacer().frame(height: 70)
                Text("시설 QR 스캐너")
                    .font(.headline)
                    .padding(.bottom, 30)
                // QR Scanner
                QRCameraCell(scannedInfo: $scannedInfo, isQRScanned: $isQRScanned)
            }
            .alert("스캔 완료", isPresented: $isQRScanned) {
                Button("OK") { RegisterFacility(data: FacilityResgistrationModel(uuid: UserDefaults.standard.string(forKey: "loginToken") ?? "", facilityNo: qrComponents[0]))}
                Button("취소") { scannedInfo = "/" }
            } message: {
                Text("\(qrComponents[1]) (\(qrComponents[2]))가 맞나요?")
            }
    }
    
    /// 시설물 등록 메서드
    private func RegisterFacility(data: FacilityResgistrationModel) {
        var cancellables = Set<AnyCancellable>()
        
        guard let upLoadData = try? JSONEncoder().encode(data) else { return }
        print(String(decoding: upLoadData, as: UTF8.self))
        let request: URLRequest
        
        do {
            request = try NM.makePostRequest(api: "/api/facility/join/us", data: upLoadData, ip: NM.facilityIp)
        } catch(let error) {
            print("error: \(error)")
            return
        }
        
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map() {
                $0.response as? HTTPURLResponse
            }
            .sink { completion in
                print(completion)
            } receiveValue: { data in
                guard let statusCode = data?.statusCode else { return }
                print("시설물 등록 statusCode == \(statusCode)")
                if statusCode == 200 {
                    print("시설물 등록 완료")
                } else if statusCode == 409 {
                    print("이미 등록 된 시설물")
                } else if statusCode == 404 {
                    print("없는 시설물")
                }
            }
            .store(in: &cancellables)
    }
    
}

