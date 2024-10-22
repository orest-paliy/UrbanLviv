//
//  ReportReviewView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 21.10.2024.
//

import SwiftUI

struct ReportReviewView: View {
    @Binding var currentReport: ReportDetails
    
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: "https://static-cse.canva.com/blob/847132/paulskorupskas7KLaxLbSXAunsplash2.jpg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            Form{
                Section("Main info"){
                    Text(currentReport.title)
                        .font(.title)
                    HStack{
                        Text(ProblemType(rawValue: currentReport.typeOfProblem)!.title)
                            .font(.title3)
                        Spacer()
                        Text(currentReport.location)
                            .font(.title3)
                    }
                    Text(currentReport.description)
                }
                    HStack{
                        Text("Creator id: \(currentReport.creatorId)")
                        Spacer()
                        Text(currentReport.timeOfCreation.prefix(10))
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ReportReviewView(currentReport: .constant(ReportDetails(id: 1, title: "Name", description: "description", imageUrl: "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg", typeOfProblem: 1, creatorId: 123, location: "Lviv", timeOfCreation: "21.09.2024", priority: 1, isDone: false)))
}
