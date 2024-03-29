//
//  AddView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct AddView: View {
    @State var userid : String
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.standartBacground.ignoresSafeArea()
                VStack(spacing: 40){
                    NavigationLink {
                        WaterView(userid : userid)
                    } label: {
                        Image("addWater")
                        
                    }
                    NavigationLink {
                        NutritionView(userid: userid)
                    } label: {
                        Image("addNutrient")
                    }
                }
            }
           
        }
    }
}

#Preview {
    AddView(userid: "123")
}
