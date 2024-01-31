//
//  TotalCardView.swift
//  Licho
//
//  Created by Atilla Ertürk on 29.01.2024.
//

import SwiftUI

struct TotalCardView: View {
    var calories : Double
    var fat : Double
    var sugar: Double
    var carb : Double
    var fiber : Double
    var fat_satured : Double
    var protein : Double
    var sodium : Double
    var potassium : Double
    var cholesterol : Double
    
    
    
    var premium = false
    
    var body: some View {


                VStack{
                    Text("TOTAL")
                    Divider().background(.white)
                    HStack {
                        HStack {
                            Spacer()
                            Text("Calories")
                        }.frame(maxWidth: .infinity)
                        HStack{
                            
                        }.frame(width: 30)
                        HStack {
                            Text(String(format: "%.2f", calories))
                            Spacer()
                        }.frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                    HStack {
                        HStack {
                            Spacer()
                            Text("Fat")
                        }.frame(maxWidth: .infinity)
                        HStack{
                            
                        }.frame(width: 30)
                        HStack {
                            Text(String(format: "%.2f", fat))
                            Spacer()
                        }.frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                    HStack {
                        HStack {
                            Spacer()
                            Text("Sugar")
                        }.frame(maxWidth: .infinity)
                        HStack{
                            
                        }.frame(width: 30)
                        HStack {
                            Text(String(format: "%.2f", sugar))
                            Spacer()
                        }.frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                    HStack {
                        HStack {
                            Spacer()
                            Text("Carb")
                        }.frame(maxWidth: .infinity)
                        HStack{
                            
                        }.frame(width: 30)
                        HStack {
                            Text(String(format: "%.2f", carb))
                            Spacer()
                        }.frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                    HStack {
                        HStack {
                            Spacer()
                            Text("Fiber")
                        }.frame(maxWidth: .infinity)
                        HStack{
                            
                        }.frame(width: 30)
                        HStack {
                            Text(String(format: "%.2f", fiber))
                            Spacer()
                        }.frame(maxWidth: .infinity)
                        
                    }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                    if premium {
                        HStack {
                            HStack {
                                Spacer()
                                Text("Fat Satured")
                            }.frame(maxWidth: .infinity)
                            HStack{
                                
                            }.frame(width: 30)
                            HStack {
                                Text(String(format: "%.2f", fat_satured))
                                Spacer()
                            }.frame(maxWidth: .infinity)
                            
                        }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                        HStack {
                            HStack {
                                Spacer()
                                Text("Protein")
                            }.frame(maxWidth: .infinity)
                            HStack{
                                
                            }.frame(width: 30)
                            HStack {
                                Text(String(format: "%.2f", protein))
                                Spacer()
                            }.frame(maxWidth: .infinity)
                            
                        }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                        HStack {
                            HStack {
                                Spacer()
                                Text("Sodium")
                            }.frame(maxWidth: .infinity)
                            HStack{
                                
                            }.frame(width: 30)
                            HStack {
                                Text(String(format: "%.2f", sodium))
                                Spacer()
                            }.frame(maxWidth: .infinity)
                            
                        }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                        HStack {
                            HStack {
                                Spacer()
                                Text("Potassium")
                            }.frame(maxWidth: .infinity)
                            HStack{
                                
                            }.frame(width: 30)
                            HStack {
                                Text(String(format: "%.2f", potassium))
                                Spacer()
                            }.frame(maxWidth: .infinity)
                            
                        }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                        HStack {
                            HStack {
                                Spacer()
                                Text("Cholesterol")
                            }.frame(maxWidth: .infinity)
                            HStack{
                                
                            }.frame(width: 30)
                            HStack {
                                Text(String(format: "%.2f", cholesterol))
                                Spacer()
                            }.frame(maxWidth: .infinity)
                            
                        }.frame(maxWidth: .infinity).padding(.horizontal, 25)
                    }
                    
                }.padding().foregroundColor(.white).background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.addButton)
                )
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
}

#Preview {
    TotalCardView(calories: 12.4242, fat: 1232, sugar: 21, carb: 321, fiber: 123, fat_satured: 121, protein: 345, sodium: 123, potassium: 234, cholesterol: 12)
}
