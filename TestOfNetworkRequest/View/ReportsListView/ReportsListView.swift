//
//  ReportsListView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import SwiftUI

struct ReportsListView: View {
    @StateObject private var viewModel = ReportListViewModel()
    @State private var searchPhrase = ""
    @State private var selectedGroupOfreports = ReportsListGroupSelectorView.SearchGroup.all
    var body: some View{
        VStack(alignment: .leading){
            //TODO: Remake on SigleViews with api call
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    VStack(alignment: .leading){
                        HStack{
                            Text("100")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("reports")
                                .foregroundStyle(.gray)
                        }
                        Text("Accepted")
                    }
                    .padding()
                    .background(Color(uiColor: .tertiarySystemBackground))
                    .cornerRadius(20)
                    .padding(.leading)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("18")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("reports")
                                .foregroundStyle(.gray)
                        }
                        Text("In Progress")
                    }
                    .padding()
                    .background(Color(uiColor: .tertiarySystemBackground))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("25")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("reports")
                                .foregroundStyle(.gray)
                        }
                        Text("In Queue")
                    }
                    .padding()
                    .background(Color(uiColor: .tertiarySystemBackground))
                    .cornerRadius(20)
                }
            }
            .refreshable {
                Task{
                    await viewModel.fetchAllReports()
                    searchPhrase = ""
                }
            }
            SearchView(searchText: $searchPhrase)
                .onChange(of: searchPhrase){
                    viewModel.fetchByName(searchPhrase: searchPhrase, group: selectedGroupOfreports)
                }
            HStack(spacing: 20){
                ReportsListGroupSelectorView(selectedGroup: $selectedGroupOfreports, typeOfGroup: .all)
                ReportsListGroupSelectorView(selectedGroup: $selectedGroupOfreports, typeOfGroup: .inProgress)
                ReportsListGroupSelectorView(selectedGroup: $selectedGroupOfreports, typeOfGroup: .done)
                ReportsListGroupSelectorView(selectedGroup: $selectedGroupOfreports, typeOfGroup: .createdByYou)
            }
            .onChange(of: selectedGroupOfreports){
                viewModel.fetchByName(searchPhrase: searchPhrase, group: selectedGroupOfreports)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            List {
                if !viewModel.reports.isEmpty{
                    ForEach(viewModel.reports, id: \.id) { report in
                        ReportListItemView(report: report)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }else{
                    ReportListItemView(report: ReportDetails())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .redacted(reason: .placeholder)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemBackground))
            .listStyle(.plain)
            .padding(.top, -10)
            .padding(.horizontal, -10)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(uiColor: .secondarySystemBackground))
        .onAppear{
            Task{
                await viewModel.fetchAllReports()
            }
        }
    }
}

#Preview {
    ReportsListView()
        .colorScheme(.dark)
}
