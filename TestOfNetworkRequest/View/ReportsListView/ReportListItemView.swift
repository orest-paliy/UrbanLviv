//
//  ReportListItemView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 29.10.2024.
//

import SwiftUI

struct ReportListItemView: View {
    var report: ReportDetails
    @State var isDescriptionShown = false
    var body: some View {
        VStack{
            ZStack{
                AsyncImage(url: URL(string: report.imageUrl), content: {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 175)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                }, placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 175)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.horizontal)
                })
                .frame(maxWidth: .infinity)
                
                HStack{
                    Text(ProblemType(rawValue: report.typeOfProblem)?.title ?? ProblemType.OTHER.title)
                        .padding(5)
                        .font(.subheadline)
                        .background(.white)
                        .cornerRadius(20)
                    Text(ProblemPriority(rawValue: report.priority)?.title ?? ProblemPriority.low.title)
                        .padding(5)
                        .font(.subheadline)
                        .background(.white)
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, maxHeight: 175, alignment: .topLeading)
                .padding(.leading, 25)
                .padding(.top)
            }
            HStack{
                Text(report.title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: isDescriptionShown ? "chevron.up" : "chevron.down")
                    .padding(.horizontal)
                    .font(.caption)
                    .onTapGesture {
                        withAnimation{
                            isDescriptionShown.toggle()
                        }
                    }
            }
            .padding(.horizontal)
            
            if isDescriptionShown{
                Text(report.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .lineLimit(5)
            }
            
            HStack(alignment: .center){
                Label(report.timeOfCreation, systemImage: "clock")
                Label(report.location, systemImage: "mappin.and.ellipse")
                Label(report.isDone ? "Done" : "In Progress",
                      systemImage: report.isDone ? "checkmark" : "progress.indicator")
            }
            .lineLimit(1)
            .font(.subheadline)
            .padding(.top, 5)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ReportListItemView(report: ReportDetails(id: 1, title: "Fallen tree on the road", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ultricies tempus eros, vel mattis mauris elementum ac. Donec pellentesque urna ac nisi efficitur consequat", imageUrl: "https://4studio.com.ua/wp-content/uplods/2021/06/2021-06-13_092047-1280x720.png ", typeOfProblem: ProblemType.ROADS.rawValue, creatorId: 1, location: "Horodotska", timeOfCreation: "21.10 10:45", priority: 1, isDone: false))
}
