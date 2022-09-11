//
//  FacilityView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/09.
//

import SwiftUI

// MARK: - MainViewStruct
struct FacilityView: View {
    
    @Binding var tabSelection: Int
    
    @StateObject var VM = MyFaciltyViewModel()
    @StateObject var loginVM = LoginViewModel.shared
    
    let buttonWidth = UIScreen.main.bounds.width - 80

    @State private var presentationOnlyLiked: Bool = false
    
    var body: some View {
        VStack {
            if loginVM.isLoggedIn {
                LoggedInView
            }
            else {
                notLoginView
            }
        }
        .refreshable {
            loadFacilityList()
        }
    }
}

// MARK: - Component
extension FacilityView {
    /// 로그인 상태가 아닐 때 표시할 뷰
    private var notLoginView: some View {
        ZStack {
            VStack(alignment: .center) {
                Image("Logo")
                Text("아직 로그인 하지 않으셨네요!")
                    .fontWeight(.bold)
                    .font(.custom(Font.theme.mainFontBold, size: 24))
                    .frame(width: buttonWidth)
                Text("로그인을 하시면 서비스를 이용할 수 있습니다.")
                    .font(.custom(Font.theme.mainFontBold, size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.theme.secondary)
                    .padding(.bottom)
                Button {
                    // 로그인 뷰로 이동
                    self.tabSelection = 1
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
    
    /// 로그인 상태일 때 표시할 뷰
    private var LoggedInView: some View {
        ZStack {
            VStack {
                // 필터 뷰
                    FilterView
                List {
                    ForEach(listModel) { item in
                        NavigationLink {
                            FacilityMainView(facilityName: item.facilityName, facilityId: item.id)
                        } label: {
                            FacilityListRow(item: item, isLiked: item.isLikedBool)
                                .environmentObject(VM)
                        }
                    }
                    .onDelete { IndexSet in
                        VM.deleteFacility(indexSet: IndexSet, userUUID: UserDefaults.standard.string(forKey: "loginToken") ?? "")
                    }
                }
                .listStyle(.plain)
            }
            
        }
        .navigationTitle("시설 리스트")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("추가", destination: FacilityRegistrationViews())
                    .foregroundColor(Color.theme.red)
        )
    }
    
    /// 필터 기능 버튼 뷰
    private var FilterView: some View {
        HStack {
            Spacer()
            Image(systemName: presentationOnlyLiked ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                .foregroundColor(.theme.red)

            Text("즐겨찾기")
                .fontWeight(.bold)
                .padding(.trailing)
                .font(.caption)
                .foregroundColor(.theme.accent)
        }
        .onTapGesture {
            presentationOnlyLiked = !presentationOnlyLiked
        }
    }
    
}

// MARK: - Functions
extension FacilityView {
    /// 시설 리스트 불러오기
    func loadFacilityList() {
        guard let UUID = UserDefaults.standard.string(forKey: "loginToken") else { return }
        VM.getFacilities(userUUID: UUID)
    }
    
    /// 필터 상태에 따른 뷰 모델 로드
    var listModel: [MyFacilityModel] {
        if presentationOnlyLiked {
            return VM.MyFacilities.filter { facility in
                return facility.isLikedBool
            }
        } else {
            return VM.MyFacilities
        }
    }
}

// MARK: - Preview
struct FacilityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FacilityView(tabSelection: .constant(1))
        }
    }
}
