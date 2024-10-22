//
//  ProblemType.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import Foundation

enum ProblemType: Int, CaseIterable{
    case ROADS,                // Проблеми з дорогами (ями, тріщини, обірвані дроти)
         GARBAGE,              // Сміття на вулицях або переповнені сміттєві баки
         CRIME,                // Кримінальні ситуації (підозрілі особи, вандалізм)
         ELECTRICITY,          // Проблеми з електропостачанням (обірвані дроти, поломка світлофорів)
         WATER_SUPPLY,         // Проблеми з водопостачанням (поломка труб, відсутність води)
         SEWAGE,               // Проблеми з каналізацією (затоплення, неприємний запах)
         PARKS,                // Проблеми у парках (неприбрані території, зруйновані лавки)
         STREET_LIGHTING,      // Несправність вуличного освітлення
         NOISE,                // Шумове забруднення (будівельні роботи, голосна музика)
         TRAFFIC,              // Проблеми з дорожнім рухом (затори, погана організація)
         ENVIRONMENT,          // Екологічні проблеми (забруднення повітря, вирубка дерев)
         PUBLIC_TRANSPORT,     // Проблеми з громадським транспортом (затримки, переповнені автобуси)
         INFRASTRUCTURE,       // Проблеми з міською інфраструктурою (пошкоджені мости, тротуари)
         HEALTH,               // Проблеми зі здоров’ям та безпекою (недостатньо лікарень, медичні інциденти)
         ANIMAL_CONTROL,       // Проблеми з безпритульними тваринами
         FIRE_HAZARD,          // Потенційна пожежна небезпека
         OTHER                 // Інші проблеми, які не підпадають під визначені категорії
    
    var title: String {
            switch self {
            case .ROADS:
                return "Проблеми з дорогами"
            case .GARBAGE:
                return "Проблеми з сміттям"
            case .CRIME:
                return "Кримінальні ситуації"
            case .ELECTRICITY:
                return "Проблеми з електропостачанням"
            case .WATER_SUPPLY:
                return "Проблеми з водопостачанням"
            case .SEWAGE:
                return "Проблеми з каналізацією"
            case .PARKS:
                return "Проблеми у парках"
            case .STREET_LIGHTING:
                return "Несправність вуличного освітлення"
            case .NOISE:
                return "Шумове забруднення"
            case .TRAFFIC:
                return "Проблеми з дорожнім рухом"
            case .ENVIRONMENT:
                return "Екологічні проблеми"
            case .PUBLIC_TRANSPORT:
                return "Проблеми з громадським транспортом"
            case .INFRASTRUCTURE:
                return "Проблеми з міською інфраструктурою"
            case .HEALTH:
                return "Проблеми зі здоров’ям"
            case .ANIMAL_CONTROL:
                return "Проблеми з безпритульними тваринами"
            case .FIRE_HAZARD:
                return "Пожежна небезпека"
            case .OTHER:
                return "Інші проблеми"
            }
        }
}
