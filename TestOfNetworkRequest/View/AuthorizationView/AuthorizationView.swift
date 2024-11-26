//
//  AuthorizationView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 20.10.2024.
//

import SwiftUI

struct AuthorizationView: View {
    @StateObject var viewModel = AuthorizationViewModel()
    @State var isSignUp = true
    @State var succesfullyAuthorized = false
    @State var needToBeValidated = false
    
    @Binding var isUserLoggined: Bool
    
    var body: some View {
        VStack(spacing: 10){
            Text(isSignUp ? "Registration".uppercased() : "Authorization".uppercased())
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 32)
                .padding(.bottom)
                .foregroundStyle(Color(uiColor: .label))
                
            VStack(spacing: 12){
                StyledTextField(title: "Email",
                                value: $viewModel.email,
                                needToBeSecured: false,
                                textFieldType: .email,
                                needToBeValidated: $needToBeValidated)
                    .keyboardType(.emailAddress)
                StyledTextField(title: "Password",
                                value: $viewModel.password,
                                needToBeSecured: true,
                                textFieldType: .password,
                                needToBeValidated: $needToBeValidated)
                
                if isSignUp{
                    StyledTextField(title: "Phone Number",
                                    value: $viewModel.phone,
                                    needToBeSecured: false,
                                    textFieldType: .phone,
                                    needToBeValidated: $needToBeValidated)
                        .keyboardType(.phonePad)
                    StyledTextField(title: "First Name",
                                    value: $viewModel.firstName,
                                    needToBeSecured: false,
                                    textFieldType: .firstName,
                                    needToBeValidated: $needToBeValidated)
                        .keyboardType(.alphabet)
                    StyledTextField(title: "Last Name",
                                    value: $viewModel.lastName,
                                    needToBeSecured: false,
                                    textFieldType: .lastName,
                                    needToBeValidated: $needToBeValidated)
                        .keyboardType(.alphabet)
                }
            }
            .padding(.horizontal)
            
            
            Button(isSignUp ? "I already have an account" : "I don't have an account yet", action: {
                withAnimation(.bouncy){
                    isSignUp.toggle()
                }
            })
            .padding(.top, 20)
            
            Button(action: {
                needToBeValidated = true
                if isSignUp{
                    Task{
                        await viewModel.signUp()
                        withAnimation(.bouncy){
                            isSignUp = !viewModel.successedSignUp
                        }
                    }
                }else{
                    Task{
                        await viewModel.signIn()
                        succesfullyAuthorized = viewModel.successedSignIn
                        isUserLoggined = succesfullyAuthorized
                    }
                }
            }, label: {
                Text(isSignUp ? "Sign Up" : "Sign In")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(45)
                    .padding(.horizontal, 40)
            })
            .padding(.bottom)
        }
        .colorScheme(.dark)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(45)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 45)
                .stroke(Color(uiColor: .tertiarySystemBackground), style: StrokeStyle(lineWidth: 4, dash: [10, 5]))
        })
        .padding()
    }
    
}

#Preview {
    AuthorizationView(isUserLoggined: .constant(true))
    
}
