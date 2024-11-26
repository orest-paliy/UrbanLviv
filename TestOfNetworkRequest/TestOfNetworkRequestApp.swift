//
//  TestOfNetworkRequestApp.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 16.10.2024.
//

import SwiftUI

@main
struct TestOfNetworkRequestApp: App {
    @State var isUserLoggined = AuthorizationService.shared.isUserLoggined()
    var body: some Scene {
        WindowGroup {
            if isUserLoggined{
                CustomNaviagationView(isUserLoggined: $isUserLoggined)
                    .colorScheme(.dark)
            }else{
                AuthorizationView(isUserLoggined: $isUserLoggined)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
                    .colorScheme(.dark)
            }
        }
    }
}
