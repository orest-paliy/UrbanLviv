//
//  ReportListItemView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 29.10.2024.
//

import SwiftUI

struct ReportListItemView: View {
    var report: ReportDetails
    
    var date: String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        if let date = dateFormatter.date(from: report.timeOfCreation){
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM yyyy"
            outputFormatter.locale = Locale(identifier: "uk_UA")
            let formatedDate = outputFormatter.string(from: date)
            return formatedDate
        }
        return nil
    }
    
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
                    
                }, placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 175)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(20)
                })
                .frame(maxWidth: .infinity)
                
                HStack{
                    Text(ProblemType(rawValue: report.typeOfProblem)?.title ?? ProblemType.OTHER.title)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .font(.subheadline)
                        .background(Color(uiColor: .tertiarySystemBackground))
                        .cornerRadius(20)
                    Text(report.priority)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .font(.subheadline)
                        .background(Color(uiColor: .tertiarySystemBackground))
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, maxHeight: 175, alignment: .topLeading)
                .padding(.leading, 8)
                .padding(.top)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
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
            .foregroundStyle(Color(uiColor: .label))
            
            if isDescriptionShown{
                Text(report.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(5)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            
            VStack(alignment: .leading){
                Label(report.location, systemImage: "mappin.and.ellipse")
                if let date = date{
                    Label(date, systemImage: "clock")
                }
            }
            .lineLimit(1)
            .font(.subheadline)
            .padding(.top, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color(uiColor: .tertiaryLabel))
        }
    }
    
    var image: UIImage?{
        if let imageData = Data(base64Encoded: report.imageUrl),
           let image = UIImage(data: imageData){
            return image
        }else{
            return nil
        }
    }
}

#Preview {
    ReportListItemView(report: ReportDetails(id: 1, title: "Fallen tree on the road", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ultricies tempus eros, vel mattis mauris elementum ac. Donec pellentesque urna ac nisi efficitur consequat", imageUrl: "https://4studio.com.ua/wp-content/uplods/2021/06/2021-06-13_092047-1280x720.png ", typeOfProblem: ProblemType.ROADS.rawValue, creatorId: 1, location: "Horodotska", timeOfCreation: "21.10 10:45", priority: "Високий", isDone: false,officialSummary: ""))
}
