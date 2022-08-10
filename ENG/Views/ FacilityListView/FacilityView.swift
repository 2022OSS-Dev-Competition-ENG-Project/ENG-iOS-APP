//
//  FacilityView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/09.
//

import SwiftUI

struct FacilityView: View {
    
    let buttonWidth = UIScreen.main.bounds.width - 80
    
    @State private var loginState: Bool = true
    @EnvironmentObject var facilityVM: FacilityListViewModel
    
    var body: some View {
        VStack {
            if loginState {
                LoginView
            }
            else {
                notLoginView
            }
        }
    }
}

struct FacilityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FacilityView()
        }
        .environmentObject(FacilityListViewModel())
    }
}

extension FacilityView {
    private var notLoginView: some View {
        ZStack {
            VStack(alignment: .center) {
                Image("Logo")
                Text("아직 로그인 하지 않으셨네요!")
                    .fontWeight(.bold)
                    .font(.custom("Apple SD Gothic Neo Bold", size: 24))
                    .frame(width: buttonWidth)
                Text("로그인을 하시면 서비스를 이용할 수 있습니다.")
                    .font(.custom("Apple SD Gothic Neo Bold", size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.theme.secondary)
                    .padding(.bottom)
                Button {
                    // 로그인 뷰로 이동
                    loginState = !loginState
                } label: {
                    Text("로그인 하러가기")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: buttonWidth, height: 40)
                        .background(Color.theme.accent)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        
                }
            }
        }
        .navigationTitle("시설 리스트")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private var LoginView: some View {
        ZStack {
            List {
                // 모델을 가져와서 수정 필요
                ForEach(facilityVM.allFacilityList) { item in
                    FacilityRow(item: item)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("시설 리스트")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("추가", destination: Text("추가 뷰"))
        )
        
        
    }
    
}
