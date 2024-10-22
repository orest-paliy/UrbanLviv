//
//  ServerResponse.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 21.10.2024.
//

import Foundation

struct ServerResponse<T: Codable>: Codable {
    let message: String
    let statusCode: Int
    let data: T
}
