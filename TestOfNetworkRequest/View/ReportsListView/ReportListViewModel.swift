//
//  ReportListViewModel.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import Foundation

@MainActor
final class ReportListViewModel: ObservableObject{
    @Published var reports: [ReportDetails] = []
    @Published var errorMessage: NetworkError?
    
    func fetchAllReports() async{
        do{
            let reports = try await RequestsNetworkService.shared.getAllReports()
            self.reports = reports
        }catch{
            self.errorMessage = error as? NetworkError
        }
    }
}
