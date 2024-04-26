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
    var didLoggedIn: (()-> Void)?
    @Published var isAuthenticated: Bool = false
    
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
                self.isAuthenticated = true
                //self.didLoggedIn?()
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


