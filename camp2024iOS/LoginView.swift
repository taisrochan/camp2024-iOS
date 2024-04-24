//
//  ContentView.swift
//  camp2024iOS
//
//  Created by Camp - 2024 on 23/04/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
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
                    //TextField("usuario",
                  //            text: $username
                   // )
                    //.padding(.vertical, 13)
                   // .padding(.leading, 24)
                   // .background(
                    //    Capsule()
                    //        .fill(.white)
                   // )
                   // .padding(.horizontal, 16)
                    
                    InputLoginView(
                        input: $viewModel.username,
                        textFieldValue: "usuario"
                        )
                    InputLoginView(input: $viewModel.password, textFieldValue: "senha")
                    //TextField("senha",
                             // text: $password
                  //  )
                   // .padding(.vertical, 13)
                   // .padding(.leading, 24)
                   // .background(
                    //    Capsule()
                   //         .fill(.white)
                   // )
                  //  .padding(.horizontal, 16)
                }
                .padding(.bottom, 32)
                Button {
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
            Image("logo_ioasys 1")
        }
    }
}

//#Preview {
    //LoginView()
//}
