//
//  InfoView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 07.11.2024.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Hey there! \nHow can we help you?")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Form(content: {
                Section("FAQS", content: {
                    QuestionView(title: "How do I give feedback on UrbanLviv?", description: "")
                    QuestionView(title: "How long will my report be processed?", description: "")
                    QuestionView(title: "Why I cannot create a new report?", description: "")
                    QuestionView(title: "Why I cannot comment on others’ reports?", description: "")
                    QuestionView(title: "What is UrbanLviv?", description: "")
                })
            })
            .cornerRadius(20)
            
            Spacer()
            
            VStack(alignment: .leading){
                Text("Still need help?")
                    .fontWeight(.bold)
                
                Text("Send us a message and we’ll reply \nas soon as we can!")
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Button("Contact us"){
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black)
            .cornerRadius(45)
            .padding(.horizontal)
            .foregroundStyle(.white)
            .padding(.bottom, 80)
        }
    }
}

#Preview {
    InfoView()
}
