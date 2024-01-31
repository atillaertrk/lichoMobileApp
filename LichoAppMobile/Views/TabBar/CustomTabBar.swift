//
//  CustomTabBar.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct CustomTabBar: View {
    
    @State var homeTap = false
    @State var addTap = false
    @State var profileTap = false
    @Binding var tabSelection : Int
    
    var body: some View {
        ZStack{
            Capsule()
                .foregroundStyle(.greenLogo)
                .frame(height : 60).padding(.horizontal)
            HStack(){
                
                
                Button {
                    self.homeTap.toggle()
                    tabSelection = 1
                } label: {
                    VStack(spacing:0) {
                        Spacer()
                        Image(systemName: "house.circle.fill").resizable().frame(width: 35, height: 35).symbolEffect(.bounce, value: homeTap)
                        
                        
                        Spacer()
                    }.foregroundStyle(.white)
                    
                    
                }.padding(.horizontal)
                Button {
                    self.addTap.toggle()
                    tabSelection = 2
                } label: {
                    VStack(spacing:0) {
                        Spacer()
                        Image(systemName: "plus.circle.fill").resizable().frame(width: 60, height: 60).symbolEffect(.bounce, value: addTap).symbolRenderingMode(.palette).foregroundStyle(.white, .addButton)
                        
                        
                        
                        Spacer()
                    }
                    
                    
                }.padding(.horizontal).padding(.bottom, 35)
                Button {
                    self.profileTap.toggle()
                    tabSelection = 3
                } label: {
                    VStack(spacing:0) {
                        Spacer()
                        Image(systemName: "person.circle.fill").resizable().frame(width: 35, height: 35).symbolEffect(.bounce, value: profileTap)
                        
                        
                        
                        Spacer()
                    }.foregroundStyle(.white)
                    
                    
                }.padding(.horizontal)
                
                
                
            }.frame(height: 70).ignoresSafeArea(.keyboard)
        }.ignoresSafeArea(.keyboard)    }
}

#Preview {
    CustomTabBar( tabSelection: Binding.constant(2))
}
