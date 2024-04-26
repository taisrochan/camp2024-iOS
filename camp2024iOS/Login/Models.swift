//
//  Models.swift
//  camp2024iOS
//
//  Created by Tais Rocha Nogueira on 25/04/24.
//

import Foundation

public struct LoginResponse: Decodable {
    let access_token: String
}

public enum LoginError: Error {
    case urlNotFound
    case decodingError
    case noData
    case otherError(message: String)
}
