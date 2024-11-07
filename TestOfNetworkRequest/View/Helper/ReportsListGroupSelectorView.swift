//
//  ReportsListGroupSelectorView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 30.10.2024.
//

import SwiftUI

struct ReportsListGroupSelectorView: View {
    @Binding var selectedGroup: SearchGroup
    var typeOfGroup: SearchGroup
    var body: some View {
        Text(typeOfGroup.rawValue)
            .font(.subheadline)
            .lineLimit(1)
            .underline(selectedGroup == typeOfGroup)
            .foregroundStyle(selectedGroup == typeOfGroup ? .black : .gray)
            .onTapGesture {
                selectedGroup = typeOfGroup
            }
    }
    
    enum SearchGroup: String{
        case all = "All"
        case inProgress = "In progress"
        case done = "Done"
        case createdByYou = "Created by you"
    }
}

#Preview {
    ReportsListGroupSelectorView(selectedGroup: .constant(.all),
                                 typeOfGroup: .all)
}
