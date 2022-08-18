//
//  QRCodeScanner.swift
//  ENG
//
//  Created by 정승균 on 2022/08/18.
//

import SwiftUI

struct QRCodeScanner: View {
    
    @State private var cardNumber: String = ""
    
    var body: some View {
        VStack {
                   Spacer().frame(height: 70)
                   
                   // QR Scanner
                   QRCameraCell(cardNumber: $cardNumber)
                   
                   Spacer()
                   
                   // Scan 한 값을 보여주는 Text
                   Text(cardNumber)
                       .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                       .minimumScaleFactor(0.1)
                       .frame(width: UIScreen.main.bounds.width - 48, height: 48, alignment: .leading)
                       .border(Color.gray, width: 1)
                       
                   Spacer().frame(height: 70)
               }
    }
}

//struct QRCodeScanner_Previews: PreviewProvider {
//    static var previews: some View {
//        QRCodeScanner()
//    }
//}
