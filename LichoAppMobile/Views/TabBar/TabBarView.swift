//
//  TabBarView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct TabBarView: View {
    @State var tabSelection : Int = 1
    var userid: String
    var body: some View {

        TabView(selection: $tabSelection,
                content:  {
            HomeView(userid: userid).tag(1)
            AddView(userid: userid).tag(2)
            ProfileView(userid : userid).tag(3)
        }).overlay(alignment: .bottom) {
            CustomTabBar( tabSelection: $tabSelection
            
            )
        }.ignoresSafeArea(.keyboard, edges: .bottom)
        

        
        
    }
}

#Preview {
    TabBarView(userid: "123").environmentObject(AuthModel())
}
