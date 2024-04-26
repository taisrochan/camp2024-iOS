//
//  LoginRequest.swift
//  camp2024iOS
//
//  Created by Tais Rocha Nogueira on 25/04/24.
//

import Foundation

public protocol LoginRequestProtocol {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> ())
}

public struct LoginRequest: LoginRequestProtocol {
    public func login(username: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> ()) {
        guard let url = URL(string: "https://keyclock.cluster-dev.ioasys.com.br/realms/camp-ioasys-2024/protocol/openid-connect/token") else {
            completion(.failure(.urlNotFound))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let parameters = ["client_id": "camp-ioasys-2024",
                          "client_secret": "BiKzHxr9ZoZRDlLjx6qG7QfnDhIoQdIf",
                          "username": "camp@ioasys.com.br",
                          "password": "tph4hyk!BZC2txm*mcb",
                          "grant_type": "password"]
        
        let formParameters = parameters.map { (key, value) in
            return "\(key)=\(value)"
        }.joined(separator: "&")
        urlRequest.httpBody = formParameters.data(using: .utf8)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                switch httpResponse.statusCode {
                case 200...299:
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                            completion(.success(decodedResponse))
                        } catch {
                            completion(.failure(.decodingError))
                        }
                    } else {
                        completion(.failure(.noData))
                    }
                default:
                    completion(.failure(.urlNotFound))
                }
            }
        }
        .resume()
    }
}
