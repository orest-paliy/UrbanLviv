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
            List{
                ForEach(viewModel.reports, content: {
                ReportListItemView(report: $0)
                })
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .foregroundStyle(.black)
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
