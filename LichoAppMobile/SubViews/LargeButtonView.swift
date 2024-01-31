//
//  LargeButtonView.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import SwiftUI

struct LargeButtonView: View {
    let title : String
    let action : () -> Void
    let color : Color
    var body: some View {
        ZStack{
            Button(action: action, label: {
                ZStack {

                    RoundedRectangle(cornerRadius: 15).foregroundStyle(color)
                    Text(title).foregroundStyle(.white)
                }
            }).frame(height: 40)
        }
    }
}

#Preview {
    LargeButtonView(title: "Buton", action: {
        
    }, color: .greenLogo)
}
