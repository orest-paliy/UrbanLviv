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
    var officialSummary: String
    
    var typeOfProblemEnum: ProblemType{
        guard let result = ProblemType(rawValue: typeOfProblem)
        else{
            return .OTHER
        }
        return result
    }
    enum CodingKeys: String, CodingKey {
        case id, title, description, imageUrl, typeOfProblem, creatorId, location, timeOfCreation, priority, isDone, officialSummary
    }
}

extension ReportDetails{
    init(){
        id = 0
        title = "Зламані вуличні ліхтарі"
        description = "Недостатньо помітні або неосвітлені пішохідні переходи становлять загрозу для пішоходів, особливо в темну пору доби. Це може призводити до підвищення ризику наїздів і травм"
        imageUrl = "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg"
        typeOfProblem = 1
        creatorId = 1
        location = "Митна площа"
        timeOfCreation = "2024-11-08T12:28:05.8267314+02:00"
        priority = "medium"
        isDone = false
        officialSummary = "Недостатнє освітлення вулиць через зламані або вимкнені ліхтарі створює небезпеку для пішоходів і водіїв у нічний час. Це може призводити до зростання кількості ДТП"
    }
}




