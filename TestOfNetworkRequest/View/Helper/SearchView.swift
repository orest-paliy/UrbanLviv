//
//  SearchView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 29.10.2024.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    var body: some View {
        HStack{
            HStack{
                TextField("Search", text: $searchText)
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(45)
//            Image(systemName: "slider.horizontal.3")
//                .frame(width: 46, height: 46)
//                .background(Color(uiColor: .tertiarySystemBackground))
//                .cornerRadius(45)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
