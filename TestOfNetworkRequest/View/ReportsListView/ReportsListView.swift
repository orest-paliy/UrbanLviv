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
    var body: some View {
        VStack(alignment: .leading){
            Text("Good afternoon,\nUserName!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
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
                    .background(.ultraThinMaterial)
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
                    .background(.ultraThinMaterial)
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
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
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
            
            List{
                ForEach(viewModel.reports, content: {
                ReportListItemView(report: $0)
                })
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .foregroundStyle(.black)
            .padding(.top, -10)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear{
            Task{
                await viewModel.fetchAllReports()
            }
        }
    }
    
}

#Preview {
    ReportsListView()
}
