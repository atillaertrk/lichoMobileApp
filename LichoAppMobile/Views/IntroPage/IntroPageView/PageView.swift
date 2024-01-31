//
//  PageView.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import SwiftUI

struct PageView: View {
    var page: IntroPageModel
   
    var body: some View {
        VStack{
          
                VStack{
                    Image(page.image).resizable().scaledToFit()
                }.padding(.horizontal, 30)
                
            
            Text(page.title).fontWeight(.bold).font(.largeTitle).padding(.bottom, 20).foregroundStyle(.greenLogo)
            Text(page.descriptions).fontDesign(.rounded).fontWeight(.regular).font(.system(size: 20))
        }.padding(.horizontal, 20)
    }
}

#Preview {
    PageView(page: IntroPageModel.samplePage)
}
