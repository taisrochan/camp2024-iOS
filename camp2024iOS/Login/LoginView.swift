//
//  ContentView.swift
//  camp2024iOS
//
//  Created by Camp - 2024 on 23/04/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State private var isLoading = false
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color("backGroundColor")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    VStack(spacing: 16) {
                        Text("Seja bem vind@!")
                            .foregroundStyle(.white)
                            .font(.title)
                        Text("HTTP Status Code")
                            .foregroundStyle(.white)
                            .font(.title2)
                    }
                    
                    .padding(.bottom, 48)
                    VStack(spacing: 16) {
                        InputLoginView(
                            input: $viewModel.username,
                            textFieldValue: "usuario"
                        )
                        InputLoginView(input: $viewModel.password, textFieldValue: "senha")
                    }
                    .padding(.bottom, 32)
                    Button {
                        isLoading = true
                        viewModel.enterButtonAction()
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(.black)
                                .frame(height: 48)
                            Text("ENTRAR")
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .frame(
                    maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                    maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/
                )
                .background(Color("backGroundColor")
                )
                if isLoading {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                            .padding()
                        Spacer()
                    }
                }
                Image("logo_ioasys 1")
            }
            .navigationTitle("Login")
                        .navigationBarHidden(true)
                        .background(
                            NavigationLink(
                                destination: NextView(),
                                isActive: $viewModel.isAuthenticated,
                                label: { EmptyView() }
                            ).hidden()
                        )
                    }
                }
            }

struct NextView: View {
    var body: some View {
        Text("Página após o login")
            .navigationTitle("Página Principal")
    }
}

//#Preview {
//    LoginView()
//}
