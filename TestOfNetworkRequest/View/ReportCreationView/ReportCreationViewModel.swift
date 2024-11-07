//
//  ReportCreationViewModel.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import SwiftUI

final class ReportCreationViewModel: ObservableObject{
    
    public func createReport(
        title: String,
        description: String,
        image: UIImage?,
        typeOfProblem: Int,
        location: String
    )async throws{
        guard let image = image,
                let jpegData = image.jpegData(compressionQuality: 0.5)
        else {
            throw NetworkError.BadData
        }
        
        let base64StringImage = jpegData.base64EncodedString()
        let creatorId = AuthorizationService.shared.getUserId()
        let newReport = ReportCreationModel(title: title, description: description, image: base64StringImage, typeOfProblem: typeOfProblem, creatorId: creatorId, location: location)
        
        do{
            try await RequestsNetworkService.shared.createNewReport(newReport: newReport)
        }catch{
            throw NetworkError.UnknownError
        }
    }
}
