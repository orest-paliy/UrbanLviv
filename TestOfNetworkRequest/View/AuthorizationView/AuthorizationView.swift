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
    
    var body: some View {
        VStack(spacing: 10){
            Text(isSignUp ? "Registration" : "Authorization")
                .font(.title2)
                .padding()
            VStack{
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
//            .alert(isPresented: $viewModel.showAlert) {
//                Alert(title: Text("Validation Error"), message: Text(viewModel.alertMessage ?? ""), dismissButton: .default(Text("OK")))
//            }
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
                    }
                }
            }, label: {
                Text(isSignUp ? "Sign Up" : "Sign In")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(20)
                    .padding(.horizontal, 60)
            })
            .padding(.bottom)
        }
        .fullScreenCover(isPresented: $succesfullyAuthorized, content: {
            ReportsListView()
        })
        .background(.red.opacity(0.2))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    AuthorizationView()
}
