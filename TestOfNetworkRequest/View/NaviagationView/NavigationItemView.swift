//
//  NavigationItemView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 29.10.2024.
//

import SwiftUI

struct NavigationItemView: View {
    var type: NavigationItems
    @Binding var currentPage: NavigationItems
    var body: some View {
        Button(action: {
            currentPage = type
        }){
            Image(systemName: type.rawValue)
                .foregroundStyle(type == .createReportPage ?
                    .black : Color(uiColor: .secondaryLabel))
                .fontWeight(.bold)
        }
        .frame(width: 50, height: 50)
        .background(type == .createReportPage ?
                    Color(uiColor: .white) :
                        Color(uiColor: .systemBackground))
        .cornerRadius(90)
    }
}

#Preview {
    NavigationItemView(type: .homePage, currentPage: .constant(.accountPage))
}
