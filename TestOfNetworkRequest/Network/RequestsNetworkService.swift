//
//  RequestsNetworkService.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import Foundation

final class RequestsNetworkService{
    public static let shared = RequestsNetworkService()
    
    private init(){
        endPoint = "http://\(hostId)/api/Report"
    }
    
    private let hostId = "54.174.171.216"
    private let endPoint: String
    
    func getAllReports() async throws -> [ReportDetails]{
        let methodTag = "/GetAllReports"
        
        guard let url = URL(string: endPoint + methodTag) else{ throw NetworkError.BadURL}
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        guard let httpResponce = responce as? HTTPURLResponse, httpResponce.statusCode == 200 else{
            throw NetworkError.BadRequest
        }
        do{
            let result = try JSONDecoder().decode([ReportDetails].self, from: data)
            print(result.count)
            return result
        }catch {
            print(error)
            throw NetworkError.BadData
        }
    }
    
    func createNewReport(newReport: ReportCreationModel) async throws{
        guard let encoded = try? JSONEncoder().encode(newReport) else {return}
        
        let methodTag = "/CreateReport"
        let url = URL(string: endPoint + methodTag)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, respoce) = try await URLSession.shared.upload(for: request, from: encoded)
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}
