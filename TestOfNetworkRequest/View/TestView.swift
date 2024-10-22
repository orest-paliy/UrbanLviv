//
//  TestView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 21.10.2024.
//

import SwiftUI

struct TestView: View {
    @State private var randInt: [Int] = []
    var body: some View {
        VStack{
            List{
                ForEach(randInt, id: \.self){i in
                    Text("\(i)")
                }
            }
            .refreshable(action: {
                generateInt()
            })
            Button("Згенерувати", action: {
                generateInt()
            })
        }
    }
    
    private func generateInt(){
        randInt = []
        for i in 0...Int.random(in: 0...20){
            randInt.append(i)
        }
    }
}

#Preview {
    TestView()
}
