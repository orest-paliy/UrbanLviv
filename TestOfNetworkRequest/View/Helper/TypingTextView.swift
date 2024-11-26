//
//  TypingTextView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 19.11.2024.
//

import SwiftUI

struct TypingTextView: View {
    let fullText: String
    @State private var displayedText: String = ""
    @State private var index: Int = 0
    let typingSpeed: Double = 0.025 // Швидкість появи символів (у секундах)
    
    var body: some View {
        Text(displayedText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onAppear {
                startTypingAnimation()
            }
    }
    
    private func startTypingAnimation() {
        displayedText = ""
        index = 0
        let timer = Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
            if index < fullText.count {
                withAnimation(.linear(duration: typingSpeed)) {
                    let currentIndex = fullText.index(fullText.startIndex, offsetBy: index)
                    displayedText.append(fullText[currentIndex])
                    index += 1
                }
            } else {
                timer.invalidate()
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}

#Preview {
    TypingTextView(fullText: "")
}
