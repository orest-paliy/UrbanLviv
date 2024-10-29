//
//  Priority.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 29.10.2024.
//

enum ProblemPriority: Int{
    case low
    case medium
    case high
    case urgent
    
    var title: String{
        switch self{
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        case .urgent:
            return "Urgent"
        }
    }
}
