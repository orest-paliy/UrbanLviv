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
    
    @Binding var path: NavigationPath
    
    var body: some View{
        VStack(alignment: .leading){
            //TODO: Remake on SigleViews with api call
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(viewModel.reports.filter({!$0.isDone}).count)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("reports")
                                .foregroundStyle(.gray)
                        }
                        Text("Accepted")
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(20)
                    .padding(.leading)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(viewModel.reports.filter({!$0.isDone}).count)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("reports")
                                .foregroundStyle(.gray)
                        }
                        Text("In Progress")
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(viewModel.reports.filter({$0.isDone}).count)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("reports")
                                .foregroundStyle(.gray)
                        }
                        Text("Done")
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(20)
                }
                .redacted(reason: viewModel.isDataLoaded ? .invalidated : .placeholder)
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
            
            List{
                if viewModel.isDataLoaded {
                    ForEach(viewModel.reports, id: \.id) { report in
                        ReportListItemView(report: report)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .padding(.top)
                            .onTapGesture {
                                path.append(report)
                            }
                    }
                    
                    Color.clear
                                .frame(height: 60) 
                                .listRowBackground(Color.clear)
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
            .refreshable {
                Task{
                    await viewModel.fetchAllReports()
                    searchPhrase = ""
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(uiColor: .systemBackground))
        .onAppear{
            Task{
                await viewModel.fetchAllReports()
            }
        }
    }
}

#Preview {
    ReportsListView(path: .constant(NavigationPath()))
        .colorScheme(.dark)
}
