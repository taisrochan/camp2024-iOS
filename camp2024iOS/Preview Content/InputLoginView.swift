//
//  InputLoginView.swift
//  camp2024iOS
//
//  Created by Camp - 2024 on 23/04/24.
//

import Foundation
import SwiftUI

struct InputLoginView: View {
    
    @State var input: Binding<String>
    var textFieldValue: String
    
    var body: some View {
        TextField(textFieldValue,
                  text: input
        )
        .padding(.vertical, 13)
        .padding(.leading, 24)
        .background(
            Capsule()
                .fill(.white)
        )
        .padding(.horizontal, 16)
    }
}
