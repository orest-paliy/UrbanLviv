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
                    QuestionView(title: "How do I give feedback on UrbanLviv?", description: "You can provide feedback on UrbanLviv by navigating to the Feedback section in the app. There, you can share your thoughts, report bugs, or suggest improvements to help us enhance your experience.")
                    QuestionView(title: "How long will my report be processed?", description: "The processing time for your report depends on its category and priority. High-priority issues are addressed faster, while others may take a few days. You can track the status of your report directly in the app.")
                    QuestionView(title: "Why I cannot create a new report?", description: "If you cannot create a new report, ensure that all required fields are completed, your internet connection is stable, and the app is updated to the latest version. If the issue persists, contact our support team through the Help section.")
                    QuestionView(title: "Why I cannot comment on others’ reports?", description: "If you're unable to comment on others' reports, it could be due to restrictions based on your user role or permissions. Make sure you're logged in with an account that has commenting access. If the issue continues, please reach out to support for assistance.")
                    QuestionView(title: "What is UrbanLviv?", description: "UrbanLviv is an app designed to allow citizens of Lviv to report city issues, such as potholes or uncollected garbage, to local authorities. Users can submit reports with photos or videos, which are processed by AI to categorize and filter them. The app also helps tourists plan city tours and collaborate with local businesses.")
                })
            })
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .cornerRadius(20)
            
            Spacer()
            
            VStack(alignment: .leading){
                Text("Still need help?")
                    .fontWeight(.bold)
                
                Text("Send us a message and we’ll reply \nas soon as we can!")
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Button("Contact us"){
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .white))
            .cornerRadius(45)
            .padding(.horizontal)
            .foregroundStyle(.black)
            .fontWeight(.bold)
            .padding(.bottom, 80)
        }
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    InfoView()
        .colorScheme(.dark)
}
