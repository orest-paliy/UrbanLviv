//
//  UserDTO.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 20.10.2024.
//

import Foundation

struct UserRegister: Codable{
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var phone: String
}

struct UserLogin: Codable{
    var email: String
    var password: String
}

struct UserIdDTO: Codable{
    var userId: Int
}

