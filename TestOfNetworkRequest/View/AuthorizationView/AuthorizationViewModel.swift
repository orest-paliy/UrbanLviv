//
//  AuthorizationViewModel.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 20.10.2024.
//

import Foundation

final class AuthorizationViewModel: ObservableObject{
    @Published var successedSignUp = false
    @Published var successedSignIn = false
    @Published var error: NetworkError?
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phone: String = ""
    
    @Published var alertMessage: String? = nil
    @Published var showAlert: Bool = false
    
    func signUp()async{
        if validateFields(isSignUp: true, email: email, password: password, firstName: firstName, lastName: lastName, phone: phone){
            let user = UserRegister(email: email, password: password, firstName: firstName, lastName: lastName, phone: phone)
            
            do{
                successedSignUp = try await AuthorizationService.shared.signUp(newUser: user)
                clearAllFields()
            }catch{
                print(error)
                self.error = error as? NetworkError
            }
        }
    }
    
    func signIn() async{
        if validateFields(isSignUp: false, email: email, password: password, firstName: "", lastName: "", phone: ""){
            let user = UserLogin(email: email, password: password)
            
            do{
                try await AuthorizationService.shared.signIn(userForLoggin: user)
                successedSignIn = AuthorizationService.shared.isUserLoggined()
            }catch{
                self.error = error as? NetworkError
            }
        }
    }
    
    func checkIfUserIsLoggined() -> Bool{
        AuthorizationService.shared.isUserLoggined()
    }
    
    func validateFields(
        isSignUp: Bool,
        email: String,
        password: String,
        firstName: String,
        lastName: String,
        phone: String
    ) -> Bool{
        var allFieldsAreOk = true
        if email.isEmpty {
            alertMessage = "Email cannot be empty."
            showAlert = true
            allFieldsAreOk = false
        } else if password.isEmpty {
            alertMessage = "Password cannot be empty."
            showAlert = true
            allFieldsAreOk = false
        } else if password.count < 8 {
            alertMessage = "Password length cannot less than 8 characters."
            showAlert = true
            allFieldsAreOk = false
        }
        
        if isSignUp{
            if firstName.isEmpty {
                alertMessage = "First name cannot be empty."
                showAlert = true
                allFieldsAreOk = false
            } else if lastName.isEmpty {
                alertMessage = "Last name cannot be empty."
                showAlert = true
                allFieldsAreOk = false
            } else if phone.isEmpty {
                alertMessage = "Phone number cannot be empty."
                showAlert = true
                allFieldsAreOk = false
            } else {
                alertMessage = nil
                showAlert = false
            }
        }
        return allFieldsAreOk
    }
    
    func clearAllFields(){
        email = ""
        password = ""
        phone = ""
        firstName = ""
        lastName = ""
    }
}
