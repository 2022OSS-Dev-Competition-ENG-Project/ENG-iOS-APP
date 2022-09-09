//
//  FacilityMainView.swift
//  ENG
//
//  Created by 정승균 on 2022/08/17.
//

import SwiftUI

struct FacilityMainView: View {
    
    var facilityName: String
    var facilityId: String
    @StateObject var VM = FacilityDetailMainViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 38) {
                Notice
                    .padding(.top, 38)
                
                MainButtons
                
                SafetyCommunicationList
                
                Spacer()
            }
            .navigationTitle(facilityName)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            loadPosters(facilityId: facilityId)
            loadNotices(facilityId: facilityId)
        }
    }
    
    private func loadPosters(facilityId: String) {
        VM.get5Posters(faciliityId: facilityId)
    }
    private func loadNotices(facilityId: String) {
        VM.get5Notices(facilityId: facilityId)
    }
}

struct FacilityMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FacilityMainView(facilityName: "그래용 시티", facilityId: "82d6e478-ef46-481e-abf4-a2425028030e")
        }
    }
}

extension FacilityMainView {
    private var Notice: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(VM.notices) { notice in
                    AsyncImage(url: URL(string: notice.contentImg)) { image in
                        ZStack {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 360, height: 120, alignment: .center)
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    } placeholder: {
                        Image(systemName: "mic.fill.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 360, height: 120, alignment: .center)
                            .background(Color.theme.green)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 4, y: 4)
                    }
                }
            }
        }
        .onAppear() {
            UIScrollView.appearance().isPagingEnabled = true
        }
    }
    
    private var MainButtons: some View {
        HStack(alignment: .center ,spacing: 28) {
            NavigationLink {
                RiskAnalysisView()
            } label: {
                VStack {
                    Image(systemName: "text.magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 3)
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.theme.red)
                    Text("위험분석")
                        .font(.custom(Font.theme.mainFontBold, size: 18))
                }
                .foregroundColor(.black)
                .frame(width: 166, height: 120, alignment: .center)
                .background(Color.theme.sub)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 4, y: 4)
            }
            
            NavigationLink {
                ReportView(facilityId: self.facilityId)
            } label: {
                VStack {
                    Image(systemName: "megaphone.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 3)
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.theme.red)
                    Text("신고하기")
                        .font(.custom(Font.theme.mainFontBold, size: 18))
                }
                .foregroundColor(.black)
                .frame(width: 166, height: 120, alignment: .center)
                .background(Color.theme.sub)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 4, y: 4)
            }
        }
    }
    
    private var SafetyCommunicationList: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.theme.secondary, lineWidth: 1)
                
            VStack {
                HStack {
                    Text("안전소통 게시판")
                        .font(.custom(Font.theme.mainFontBold, size: 16))
                    
                    Spacer()
                    
                    NavigationLink {
                        FacilityPosterListView(facilityId: facilityId)
                    } label: {
                        Text("더보기>")
                            .font(.custom(Font.theme.mainFontBold, size: 13))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 13)
                
                // 리스트 불러오기
                ForEach(VM.posters) { item in
                    NavigationLink {
                        PosterDetailView(contentNum: item.id)
                    } label: {
                        PosterListRowView(posterNumber: item.id, posterTitle: item.contentTitle)
                            .padding(.horizontal, 16)
                            .foregroundColor(.black)
                    }

                    
                }
            }
            .padding(.bottom, 16)
        }
        .frame(width: 360, alignment: .center)
        .frame(minHeight: 0, maxHeight: .infinity)
        .padding(.bottom, 15)
    }
}
