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
                return "Дороги"
            case .GARBAGE:
                return "Сміття"
            case .CRIME:
                return "Кримінальні ситуації"
            case .ELECTRICITY:
                return "Елекропостачання"
            case .WATER_SUPPLY:
                return "Водопостачання"
            case .SEWAGE:
                return "Каналізація"
            case .PARKS:
                return "Проблеми у парках"
            case .STREET_LIGHTING:
                return "Вуличне освітлення"
            case .NOISE:
                return "Шумове забруднення"
            case .TRAFFIC:
                return "Доорожній рух"
            case .ENVIRONMENT:
                return "Екологічні проблеми"
            case .PUBLIC_TRANSPORT:
                return "Громадський транспорт"
            case .INFRASTRUCTURE:
                return "Міська інфрастроктура"
            case .HEALTH:
                return "Проблеми зі здоров’ям"
            case .ANIMAL_CONTROL:
                return "Безпритульні тварини"
            case .FIRE_HAZARD:
                return "Пожежна небезпека"
            case .OTHER:
                return "Інші проблеми"
            }
        }
}
