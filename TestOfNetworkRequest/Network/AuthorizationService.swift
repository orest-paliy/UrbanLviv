//
//  AuthorizationService.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 20.10.2024.
//

import Foundation

final class AuthorizationService{
    public static let shared = AuthorizationService()
    
    private init(){
        endPoint = "http://\(hostId)/api/Auth"
    }
    
    private let hostId = "54.174.171.216"
    private let endPoint: String
    
    func signUp(newUser: UserRegister) async throws -> Bool{
        let methodTag = "/UserRegister"
        
        guard let url = URL(string: endPoint + methodTag) else{throw NetworkError.BadURL}
        
        let encodedData = try JSONEncoder().encode(newUser)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let (_, responce) = try await URLSession.shared.upload(for: request, from: encodedData)
        
        if let httpResponce = responce as? HTTPURLResponse{
            if httpResponce.statusCode != 200{
                print(responce)
                throw NetworkError.BadRequest
            }
        }
        return true
    }
    
    func signIn(userForLoggin: UserLogin) async throws{
        let methodTag = "/UserLogin"
        guard let url = URL(string: endPoint + methodTag) else{ throw NetworkError.BadURL}
        let encodedData = try JSONEncoder().encode(userForLoggin)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let (data, responce) = try await URLSession.shared.upload(for: request, from: encodedData)
        
        if let httpResponce = responce as? HTTPURLResponse{
            if httpResponce.statusCode != 200{
                throw NetworkError.BadRequest
            }
        }
        do {
            let serverResponse = try JSONDecoder().decode(ServerResponse<UserIdDTO>.self, from: data)
            let userId = serverResponse.data.userId
            saveUserId(userId: userId)
        } catch {
            print("Помилка декодування: \(error)")
        }
        
    }
    
    private func saveUserId(userId: Int){
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    func getUserId() -> Int{
        if isUserLoggined(){
            return UserDefaults.standard.integer(forKey: "userId")
        }
        return Int.max
    }
    
    func isUserLoggined() -> Bool{
        guard let _ = UserDefaults.standard.object(forKey: "userId")
            else{return false}
        return true
    }
    
    func logOut(){
        UserDefaults.standard.removeObject(forKey: "userId")
    }
}
