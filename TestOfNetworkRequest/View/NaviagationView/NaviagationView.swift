//
//  NaviagationView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 29.10.2024.
//

import SwiftUI

struct NaviagationView: View {
    @State private var selectedPage: NavigationItems = .homePage
    @State private var isNewReportViewShown = false
    var body: some View {
        ZStack{
            switch selectedPage {
            case .homePage:
                ReportsListView()
            case .accountPage:
                Text("profilePage")
            case .infoPage:
                Text("InfoPage")
            case .createReportPage:
                Text("").onAppear{
                    isNewReportViewShown = true
                    selectedPage = .homePage
                }
            }
            
            HStack(spacing: 15){
                HStack(spacing: 15){
                    NavigationItemView(type: .homePage, currentPage: $selectedPage)
                    NavigationItemView(type: .accountPage, currentPage: $selectedPage)
                    NavigationItemView(type: .infoPage, currentPage: $selectedPage)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .cornerRadius(90)
                NavigationItemView(type: .createReportPage, currentPage: $selectedPage)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $isNewReportViewShown, content: {
            ReportCreationView(isViewShown: $isNewReportViewShown)
        })
    }
}

#Preview {
    NaviagationView()
}
