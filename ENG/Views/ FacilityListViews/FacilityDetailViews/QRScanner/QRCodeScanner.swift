//
//  QRCodeScanner.swift
//  ENG
//
//  Created by 정승균 on 2022/08/18.
//

import SwiftUI

struct QRCodeScanner: View {

    @State private var cardNumber: String = "//"
    @State private var isCardNumberChange: Bool = false
    
    private var qrComponents: [String] {
        return cardNumber.components(separatedBy: "/")
    }
    var body: some View {
        VStack {
                Spacer().frame(height: 70)
                Text("시설 QR 스캐너")
                    .font(.headline)
                    .padding(.bottom, 30)
                // QR Scanner
                QRCameraCell(cardNumber: $cardNumber, isCardNumberChange: $isCardNumberChange)
            }
            .alert("스캔 완료", isPresented: $isCardNumberChange) {
                Button("OK") { }
                Button("취소") { cardNumber = "/" }
            } message: {
                Text("\(qrComponents[1]) (\(qrComponents[2]))가 맞나요?")
            }
    }
}

