//
//  AccountView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 19.11.2024.
//

import SwiftUI

struct AccountView: View {
    @State var showlogoutAlert = false
    
    @Binding var isUserLoggined: Bool
    
    var body: some View {
        
        VStack{
            ZStack(){
                Circle()
                    .frame(maxWidth: 150)
                    .foregroundStyle(.separator)
                
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 80)
                    .fontWeight(.ultraLight)
                    .foregroundStyle(.white)
            }
            Text("id: \(UserDefaults.standard.object(forKey: "userId") ?? "")")
                .font(.title3)
            
            Form{
                Section("Privacy"){
                    Button(action: {
                        showlogoutAlert = true
                    }) {
                        HStack{
                            Label("Logout", systemImage: "figure.dance")
                            Spacer()
                            Image(systemName: "x.square")
                        }
                        .foregroundStyle(.red)

                    }
                    .alert(isPresented: $showlogoutAlert, content: {
                        Alert(
                            title: Text("Are you sure you want to log out?"),
                            primaryButton: .destructive(Text("Yes"), action: {
                                AuthorizationService.shared.logOut()
                                isUserLoggined = false
                            }),
                            secondaryButton: .cancel())
                    })
                }
            }
        }
        .colorScheme(.dark)
    }
}

#Preview {
    AccountView(isUserLoggined: .constant(true))
}
