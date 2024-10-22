//
//  TestOfNetworkRequestApp.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 16.10.2024.
//

import SwiftUI

@main
struct TestOfNetworkRequestApp: App {
    var body: some Scene {
        WindowGroup {
            if AuthorizationService.shared.isUserLoggined(){
                ReportsListView()
            }else{
                AuthorizationView()
            }
        }
    }
}
