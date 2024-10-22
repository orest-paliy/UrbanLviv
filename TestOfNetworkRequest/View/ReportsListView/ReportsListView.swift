//
//  ReportsListView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import SwiftUI

struct ReportsListView: View {
    @StateObject private var viewModel = ReportListViewModel()
    @State private var showCreationView = false
    
    //TODO: delete asap
    @State private var logoutPressed = false
    
    @State private var path = NavigationPath()
    
    var body: some View {
        
        ZStack (alignment: .bottom){
            NavigationStack(path: $path){
                List{
                    ForEach($viewModel.reports){ report in
                        Button(action: {
                            path.append(report.wrappedValue)
                        }, label: {
                            VStack{
                                Image(systemName: "person")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 150)
                                    .padding(20)
                                Text(report.wrappedValue.title)
                                HStack {
                                    Text(report.wrappedValue.description)
                                    Spacer()
                                    Text(report.wrappedValue.location)
                                }
                                .padding()
                            }
                            .frame(height: 200)
                            .background(.pink)
                            .cornerRadius(20)
                            
                        })
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .foregroundStyle(.black)
                    }
                }
                .navigationTitle("All Problems")
                .onAppear{
                    Task{
                        await viewModel.fetchAllReports()
                    }
                }
                .refreshable{
                    Task{
                        await viewModel.fetchAllReports()
                    }
                }
                .navigationDestination(for: ReportDetails.self, destination:{report in
                    @State var reportBinding = report
                    ReportReviewView(currentReport: $reportBinding)
                })
            }
            Section {
                HStack{
                    Button(action: {
                        showCreationView = true
                    }){
                        VStack{
                            Image(systemName: "plus")
                            Text("Create")
                        }
                    }.padding(.trailing, 50)
                    
                    Button(action: {
                        UserDefaults.standard.removeObject(forKey: "userId")
                        logoutPressed = true
                    }){
                        VStack{
                            Image(systemName: "chevron.right")
                            Text("Logout")
                        }
                        .foregroundStyle(.red)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
            }
            .shadow(radius: 20)
        }
        .fullScreenCover(isPresented: $logoutPressed, content: {
            AuthorizationView()
        })
        .fullScreenCover(isPresented: $showCreationView, content: {
            ReportCreationView(isShown: $showCreationView, reportListViewModel: viewModel)
        })
        .frame(maxHeight: .infinity)
    }
    
}

#Preview {
    ReportsListView()
}
