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
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(45)
            Image(systemName: "slider.horizontal.3")
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(45)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
