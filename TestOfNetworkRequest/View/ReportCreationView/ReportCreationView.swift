//
//  ReportCreationView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import SwiftUI

struct ReportCreationView: View {
    @StateObject private var viewModel = ReportCreationViewModel()
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var image: String = ""
    @State private var typeOfProblem: ProblemType = .OTHER
    @State private var creatorId: Int = 1
    @State private var location: String = ""
    @State private var allFieldsWereValidated = false
    
    @State private var needToBeValidated = false
    
    @Binding var isShown: Bool
    @ObservedObject var reportListViewModel: ReportListViewModel
    
    var body: some View {
        VStack(spacing: 10){
            Label("Нова скарга", systemImage: "keyboard")
                .font(.title3)
                .padding(.top)
            VStack{
                
                StyledTextField(title: "Назва проблеми",
                                value: $title,
                                needToBeSecured: false,
                                textFieldType: .other,
                                needToBeValidated: $needToBeValidated)
                StyledTextField(title: "Опис",
                                value: $description,
                                needToBeSecured: false,
                                textFieldType: .other,
                                needToBeValidated: $needToBeValidated)
                StyledTextField(title: "Місцезнаходження",
                                value:  $location,
                                needToBeSecured: false,
                                textFieldType: .other,
                                needToBeValidated: $needToBeValidated)
            }
            .padding()
            
            Form {
                Picker("Тип проблеми", selection: $typeOfProblem) {
                    ForEach(ProblemType.allCases, id: \.self) { problem in
                        Text(problem.title)
                    }
                }
            }
            .frame(maxHeight: 100)
            
            Button(action: {
                createNewReport()
            }, label: {
                Text("Create New Report")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(allFieldsWereValidated ? .blue : .gray)
                    .cornerRadius(20)
            })
            .padding()
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(20)
        .padding()
    }
    
    private func createNewReport() {
        Task {
            do {
                await viewModel.createReport(
                    title: title,
                    description: description,
                    image: image,
                    typeOfProblem: typeOfProblem.rawValue,
                    location: location
                )
                isShown = false
                await reportListViewModel.fetchAllReports() // Оновлення списку
            } catch {
                // Обробка помилок (можна вивести повідомлення)
                print("Error creating report: \(error)")
            }
        }
    }
}

#Preview {
    ReportCreationView(isShown: .constant(true), reportListViewModel: ReportListViewModel())
}
