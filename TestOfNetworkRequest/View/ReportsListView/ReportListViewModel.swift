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
    
    private var notChangingReportsArray: [ReportDetails] = []
    func fetchByName(searchPhrase: String, group: ReportsListGroupSelectorView.SearchGroup){
        if searchPhrase.isEmpty{
            reports = fetchByGroup(group: group)
        }else{
            reports = fetchByGroup(group: group).filter{
                $0.title.contains(searchPhrase.lowercased())
            }
        }
    }
    
    func fetchByGroup(group: ReportsListGroupSelectorView.SearchGroup) -> [ReportDetails]{
        switch group{
        case .all:
            return notChangingReportsArray
        case .inProgress:
            return notChangingReportsArray.filter{ !$0.isDone }
        case .done:
            return notChangingReportsArray.filter{ $0.isDone }
        case .createdByYou:
            return notChangingReportsArray.filter{
                $0.creatorId == AuthorizationService.shared.getUserId()
            }
        }
    }
    
    func fetchAllReports() async{
        do{
            let reports = try await RequestsNetworkService.shared.getAllReports()
            notChangingReportsArray = reports
            self.reports = notChangingReportsArray
        }catch{
            self.errorMessage = error as? NetworkError
        }
    }
}
