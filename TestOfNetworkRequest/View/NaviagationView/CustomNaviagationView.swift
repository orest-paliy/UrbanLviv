//
//  NaviagationView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 29.10.2024.
//

import SwiftUI

struct CustomNaviagationView: View {
    @State private var selectedPage: NavigationItems = .homePage
    @State private var isNewReportViewShown = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                switch selectedPage {
                case .homePage:
                    ReportsListView(path: $path)
                case .accountPage:
                    Text("profilePage")
                case .infoPage:
                    InfoView()
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
                    .colorScheme(.dark)
            })
            .colorScheme(.dark)
            .navigationDestination(for: ReportDetails.self, destination: {item in
                ReportReviewView(currentReport: item)
            })
        }
    }
}

#Preview {
    CustomNaviagationView()
}
