//
//  StyledTextFieldViewModel.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 20.10.2024.
//

import SwiftUI

final class StyledTextFieldViewModel: ObservableObject{
    @Binding var value: String
    @Published var validationError: String
    
    var typeOfTextField : TypesOfTextField
    
    init(value: Binding<String>, validationError: String, typeOfTextField: TypesOfTextField) {
        self._value = value
        self.validationError = validationError
        self.typeOfTextField = typeOfTextField
    }
    
    func checkIfTextFieldIsValid(){
        withAnimation {
            if value.isEmpty{
                validationError = typeOfTextField.rawValue + ValidationError.Empty.rawValue
            }else{
                if typeOfTextField == .password{
                    if value.count < 8{
                        validationError = typeOfTextField.rawValue + ValidationError.TooShort.rawValue
                    }
                }
            }
        }
    }
}

enum TypesOfTextField: String{
    case email = "Email "
    case phone = "Phone number "
    case password = "Password "
    case firstName = "First name "
    case lastName = "Last name "
    case other = "This field "
}
