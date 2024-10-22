//
//  ValidationError.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 20.10.2024.
//

import Foundation

enum ValidationError: String{
    case Empty = "could not be empty"
    case TooShort = "could not have less than 8 characters"
    case PhoneNumberWithLetters = "could not contain letters"
}
