//
//  LoginViewModel.swift
//  camp2024iOS
//
//  Created by Camp - 2024 on 23/04/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    let loginRequestProtocol: LoginRequestProtocol
    
    init(username: String = "",
         password: String = "",
         loginRequestProtocol: LoginRequestProtocol = LoginRequest()) {
        self.username = username
        self.password = password
        self.loginRequestProtocol = loginRequestProtocol
    }
    
    func enterButtonAction() {
        debugPrint(username)
        debugPrint(password)
        
        loginRequestProtocol.login(username: username, password: password) { result in
            switch result {
            case .success:
                print("Login bem-sucedido!")
            case .failure(let error):
                switch error {
                case .urlNotFound:
                    print("Erro: URL não encontrada.")
                case .decodingError:
                    print("Erro ao decodificar os dados.")
                case .otherError(let errorMessage):
                    print("Erro: \(errorMessage)")
                case .noData:
                    print("Erro de data")
                }
            }
        }
    }
}

public protocol LoginRequestProtocol {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> ())
}

public struct LoginRequest: LoginRequestProtocol {
    public func login(username: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> ()) {
        guard let url = URL(string: "https://keyclock.cluster-dev.ioasys.com.br/realms/camp-ioasys-2024/protocol/openid-connect/token)") else {
            completion(.failure(.urlNotFound))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let parameters = ["client_id": "camp-ioasys-2024",
                          "client_secret": "BiKzHxr9ZoZRDlLjx6qG7QfnDhIoQdIf",
                          "username": "username",
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

public struct LoginResponse: Decodable {
    let access_token: String
}

public enum LoginError: Error {
    case urlNotFound
    case decodingError
    case noData
    case otherError(message: String)
}
