//
//  NutritionListCard.swift
//  Licho
//
//  Created by Atilla Ertürk on 29.01.2024.
//

import SwiftUI

struct NutritionListCard: View {
    var nameQuantitiy : String
    var fat : Double
    var cal : Double
    var sugar : Double
    var carb : Double
    var body: some View {
        VStack {
            Text(nameQuantitiy).font(.headline).fontWeight(.bold).padding(.top).foregroundStyle(.gray)
            Divider()
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        Text("Fat").padding(3).background(RoundedRectangle(cornerRadius: 5).foregroundStyle(.homeOrange)).clipShape(RoundedRectangle(cornerRadius: 5)).foregroundStyle(.white).font(.subheadline).lineLimit(1)
                       
                        Text(String(format: "%.2f" ,fat)).font(.subheadline).lineLimit(1)
                    }.frame(alignment: .leading)
                    
                    
                    HStack {
                        Text("Cal").padding(3).background(RoundedRectangle(cornerRadius: 5).foregroundStyle(.pink)).clipShape(RoundedRectangle(cornerRadius: 5)).foregroundStyle(.white).font(.subheadline).lineLimit(1)
                        Text(String(format: "%.2f" ,cal)).font(.subheadline).lineLimit(1)

                    }.frame( alignment: .leading)
                                            
                    
                }.padding(.trailing, 10)
                
                VStack(alignment: .trailing){
                    HStack {
                        Text("Sugar").padding(3).background(RoundedRectangle(cornerRadius: 5).foregroundStyle(.pink)).clipShape(RoundedRectangle(cornerRadius: 5)).foregroundStyle(.white).font(.subheadline).lineLimit(1)
                        Text(String(format: "%.2f" ,sugar)).font(.subheadline).lineLimit(1)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    HStack {
                        Text("Carb").padding(3).background(RoundedRectangle(cornerRadius: 5).foregroundStyle(.orange)).clipShape(RoundedRectangle(cornerRadius: 5)).foregroundStyle(.white).lineLimit(1).font(.subheadline)
                        Text(String(format: "%.2f" ,carb)).lineLimit(1).font(.subheadline)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                }.frame(maxWidth: .infinity)
                
                VStack{
                    
                    Image(systemName: "arrow.left").padding(.trailing, 0).foregroundStyle(.white).font(.footnote)
                    Image(systemName: "trash").foregroundStyle(.white).padding(.top, 5).font(.footnote)
                    
                }.frame(maxWidth: 30, maxHeight: 80).background(.red).padding(0).padding(.top, -5)
            }.frame(maxWidth: .infinity).padding(.leading, 5)
            
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    NutritionListCard(nameQuantitiy: "100 g Bread", fat: 2321232.1223, cal: 12312.2112, sugar: 12122221.212, carb: 1212.1)
}
