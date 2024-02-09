//
//  HeaderView.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack{
            
            Image("logo").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 300)
                

        }.padding(-15)
    }
}

#Preview {
    HeaderView()
}
