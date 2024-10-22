//
//  NetworkErrors.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 18.10.2024.
//

import Foundation

enum NetworkError: Error{
    case BadURL
    case BadRequest
    case BadData
    case NoResponse
    case DecodingError
    case UnknownError
}
