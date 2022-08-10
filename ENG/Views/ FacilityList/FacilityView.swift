//
//  FacilityView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/09.
//

import SwiftUI

struct FacilityView: View {
    var body: some View {
        VStack {
            Text("accent")
                .foregroundColor(Color.theme.accent)
            Text("Red")
                .foregroundColor(Color.theme.red)
            Text("secondary")
                .foregroundColor(Color.theme.secondary)
            Text("sub")
                .foregroundColor(Color.theme.sub)
        }
    }
}

struct FacilityView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityView()
    }
}
