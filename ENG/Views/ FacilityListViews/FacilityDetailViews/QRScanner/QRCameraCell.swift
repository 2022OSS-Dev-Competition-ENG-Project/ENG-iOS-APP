//
//  QRCameraCell.swift
//  ENG
//
//  Created by 정승균 on 2022/08/18.
//

import SwiftUI
// 카메라, 오디오 등을 제어하기 위해 사용되는 Apple의 라이브러리
import AVFoundation

struct QRCameraCell: View {
    // 카메라 화면이 들어갈 이미지
    @State private var inputImage: UIImage?
    @Binding var cardNumber: String
    
    // Notification은 앱 내에서 특정상황에 값을 넘겨주고 싶을 때 해당 키로 등록되어 있는 Observer들에게 Notification을 하고 그 값을 전달할 수도 있습니다. 다만 많이 사용하게 되면 앱 성능을 저하시킬 수 있으니 주의하세요!
    // 아래 예시는 "Card Number Recognized By QR" 이라는 Notification에 대한 Observer 입니다.
    let cardNumberFromController = NotificationCenter.default
                .publisher(for: NSNotification.Name("Card Number Recognized By QR"))
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 24)
                    
                // ViewController를 SwiftUI의 View로 변환하여 보여줍니다.
                CustomCameraRepresentable(image: self.$inputImage, cardNumber: $cardNumber)
                
                Spacer().frame(width: 24)
            }
        }
        // Notification을 받으면 그 값을 cardNumber에 할당
        .onReceive(cardNumberFromController) { (output) in
            cardNumber = output.object as? String ?? ""
        }
    }
}
