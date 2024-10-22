//
//  ReportCreationViewModel.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import Foundation

@MainActor
final class ReportCreationViewModel: ObservableObject{
    
    @Published var error: NetworkError?
    
    public func createReport(
        title: String,
        description: String,
        image: String,
        typeOfProblem: Int,
        location: String
    )async{
        let creatorId = AuthorizationService.shared.getUserId()
        let newReport = ReportCreationModel(title: title, description: description, image: image, typeOfProblem: typeOfProblem, creatorId: creatorId, location: location)
        do{
            try await RequestsNetworkService.shared.createNewReport(newReport: newReport)
        }catch{
            self.error = error as? NetworkError
        }
    }
}
