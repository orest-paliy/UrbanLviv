//
//  ReportReviewView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 21.10.2024.
//

import SwiftUI

struct ReportReviewView: View {
    var currentReport: ReportDetails
    
    private var date: String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        if let date = dateFormatter.date(from: currentReport.timeOfCreation){
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM yyyy"
            outputFormatter.locale = Locale(identifier: "uk_UA")
            let formatedDate = outputFormatter.string(from: date)
            return formatedDate
        }
        return nil
    }
    
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: currentReport.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 400,maxHeight: 270)
                        .clipped()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 270)
            }
            VStack(alignment: .leading){
                LocationMapView(query: currentReport.location)
                    .frame(height: 270)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.black, Color.clear, Color.clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(maxWidth: .infinity, maxHeight: 270, alignment: .bottomTrailing)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(radius: 1, y: -5)
                    .scrollClipDisabled()
                VStack(alignment: .leading, spacing: 8){
                    
                    Text(currentReport.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(currentReport.description)
//                    Text("Тип проблеми: \(currentReport.typeOfProblemEnum.title)")
//                        .foregroundStyle(Color(uiColor: .secondaryLabel))
//                    Text("Пріоритет розгялу: \(currentReport.priority)")
//                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    
                    
                    ScrollView{
                        VStack(spacing: 20){
                            VStack(alignment: .leading){
                                HStack{
                                    Image("chatGPT")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                    Text("ChatGPT summary")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .opacity(0.7)
                                TypingTextView(fullText: currentReport.officialSummary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(20)
                            
                            VStack(alignment: .leading){
                                
                                HStack{
                                    Label(currentReport.location, systemImage: "mappin.and.ellipse")
                                    Spacer()
                                    if let date = date{
                                        Label(date, systemImage: "clock")
                                    }
                                }
                                
                                HStack{
                                    Label(currentReport.isDone ? "Done" :"In progress",
                                          systemImage: currentReport.isDone ? "checkmark" : "progress.indicator")
                                    Spacer()
                                    Label("Creator id: \(currentReport.creatorId)", systemImage: "person")
                                }
                            }
                            .foregroundStyle(Color(uiColor: .tertiaryLabel))
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, -120)
            }
            .padding(.top, -40)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
        .colorScheme(.dark)
    }
    
}

#Preview {
    ReportReviewView(currentReport: ReportDetails())
}
