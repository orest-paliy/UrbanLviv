//
//  ReportCreationView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import SwiftUI
import PhotosUI

struct ReportCreationView: View {
    @StateObject private var viewModel = ReportCreationViewModel()
    @Binding var isViewShown: Bool
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State var imageSelection: PhotosPickerItem? = nil
    @State var uiImage: UIImage? = nil
    @State private var typeOfProblem: ProblemType = .OTHER
    @State private var priority: ProblemPriority = .low
    @State private var location: String = ""
    
    @State private var isReportCreationEndingShown = false
    
    var body: some View {
        ZStack{
            VStack{
                ScrollView{
                    VStack(alignment: .leading){
                        HStack{
                            Button("Tell us what problem you've faced", systemImage: "chevron.backward", action: {
                                isViewShown = false
                            })
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        }
                        
                        Text("Name of problem")
                            .padding(.top)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        TextField("E.g. Water Leakage", text: $title)
                            .padding()
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(45)
                        
                        Text("Description of problem")
                            .padding(.top)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        TextField("E.g. Water Leakage happend in..", text: $description)
                            .padding()
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(45)
                        
                        Text("Problem type")
                            .padding(.top)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        HStack {
                            Picker("Problem Type", selection: $typeOfProblem) {
                                ForEach(ProblemType.allCases, id: \.self, content: {
                                    Text($0.title).tag($0)
                                })
                            }
                            .accentColor(.gray)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(45)
                        
                        Text("Priority")
                            .padding(.top)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        HStack{
                            PriorityView(selectedPriority: $priority, priority: .low)
                            PriorityView(selectedPriority: $priority, priority: .medium)
                            PriorityView(selectedPriority: $priority, priority: .high)
                            PriorityView(selectedPriority: $priority, priority: .urgent)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Text("Image")
                            .padding(.top)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        
                        ZStack{
                            Image(uiImage: uiImage ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 150)
                                .clipped()
                                .background(Color(uiColor: .secondarySystemBackground))
                                .cornerRadius(20)
                                .allowsHitTesting(uiImage != nil)
                            if uiImage == nil{
                                PhotosPicker(
                                    selection: $imageSelection,
                                    matching: .images,
                                    photoLibrary: .shared()) {
                                        Image(systemName: "camera.viewfinder")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 150)
                    }
                }
                
                Button(action: {
                    Task{
                        try? await viewModel.createReport(title: title, description: description, image: uiImage, typeOfProblem: typeOfProblem.rawValue, location: location)
                    }
                    withAnimation{
                        isReportCreationEndingShown = true
                    }
                }, label: {
                    Text("Create A Report")
                        .foregroundStyle(.black)
                        .fontWeight(.heavy)
                })
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(45)
                .padding(.top)
                
            }
            .onChange(of: imageSelection) {
                Task {
                    if let data = try? await imageSelection?.loadTransferable(type: Data.self) {
                        uiImage = UIImage(data:data)
                        return
                    }
                }
            }
            .padding()
            .blur(radius: isReportCreationEndingShown ? 15 : 0)
            
            if isReportCreationEndingShown{
                VStack(spacing: 16){
                    Text("Thank you for your request!")
                    Text("Your request is being \nprocessed.")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("The status of your request is going to \nbe sent to your email.")
                        .multilineTextAlignment(.center)
                    
                    Button("Okay"){
                        isViewShown = false
                    }
                    .padding()
                    .padding(.horizontal, 32)
                    .background(.black)
                    .cornerRadius(45)
                    .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {
    ReportCreationView(isViewShown: .constant(true))
        .colorScheme(.dark)
}
