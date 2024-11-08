//
//  ReportRequest.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 16.10.2024.
//

import Foundation

struct ReportCreationModel: Encodable{
    var title: String
    var description: String
    var image: String
    var typeOfProblem: Int
    var creatorId: Int
    var location: String
}

struct ReportDetails: Decodable, Identifiable, Hashable{
    var id: Int
    var title: String
    var description: String
    var imageUrl: String
    var typeOfProblem: Int
    var creatorId: Int
    var location: String
    var timeOfCreation: String
    var priority: String
    var isDone: Bool
    
    var typeOfProblemEnum: ProblemType{
        guard let result = ProblemType(rawValue: typeOfProblem)
        else{
            return .OTHER
        }
        return result
    }
    enum CodingKeys: String, CodingKey {
        case id, title, description, imageUrl, typeOfProblem, creatorId, location, timeOfCreation, priority, isDone
    }
}

extension ReportDetails{
    init(){
        id = 0
        title = "title"
        description = "somedescription"
        imageUrl = ""
        typeOfProblem = 1
        creatorId = 1
        location = "location"
        timeOfCreation = "2024-11-08T12:28:05.8267314+02:00"
        priority = "medium"
        isDone = false
    }
}




