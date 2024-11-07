//
//  CreationTextFieldView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 30.10.2024.
//

import SwiftUI

struct PriorityView: View {
    @Binding var selectedPriority: ProblemPriority
    var priority: ProblemPriority
    var body: some View {
        Button(priority.title, action: {
            selectedPriority = priority
        })
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(45)
        .foregroundStyle(selectedPriority == priority ? .blue : .gray)
    }
}

#Preview {
    PriorityView(selectedPriority: .constant(.low), priority: .low)
}
