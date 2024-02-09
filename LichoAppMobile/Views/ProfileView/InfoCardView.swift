//
//  InfoCardView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct InfoCardView: View {
    var height : Double
    var weight : Double
    var BMR : Double
    var BMI : Double
    var idealWeight : Double
    var heightUnit : String
    var weiightUnit : String
    var body: some View {
        VStack{
            //line
                HStack {
                    HStack {
                                            
                        Text("\(String(format:"%.2f", height)) \(heightUnit)").lineLimit(1)
                                                .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        }.frame(maxWidth: .infinity)
                                        
                    HStack {
                                            Text("\(String(format:"%.2f", weight)) \(weiightUnit)").lineLimit(1)
                                                .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        }.frame(maxWidth: .infinity)
                                    }.frame(maxWidth: .infinity)
//line
            HStack {
                HStack {
                    
                    Text("Ideal Weight").lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                    
                }.frame(maxWidth: .infinity)
                
                HStack {
                    if idealWeight < 0 {
                        Text("None").lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text(String(format:"%.2f", idealWeight)).lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                }.frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity)
//line
            HStack {
                HStack {
                                
                                Text("BMR").lineLimit(1)
                                    .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                                
                            }.frame(maxWidth: .infinity)
                            
                HStack {
                                Text(String(format:"%.2f", BMR)).lineLimit(1)
                                    .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                                
                            }.frame(maxWidth: .infinity)
                        }.frame(maxWidth: .infinity)
            
            //line
                HStack {
                    HStack {
                                            
                                            Text("BMI").lineLimit(1)
                                                .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        }.frame(maxWidth: .infinity)
                                        
                    HStack {
                                            Text(String(format:"%.2f", BMI)).lineLimit(1)
                                                .fixedSize(horizontal: true, vertical: false).frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        }.frame(maxWidth: .infinity)
                                    }.frame(maxWidth: .infinity)
            

        }.padding().foregroundColor(.softBlack).background(
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(.softBlack, lineWidth: 0.2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 25.0)).frame(maxWidth: .infinity)
    }
}

#Preview {
    InfoCardView(height: 182.123, weight: 88.234, BMR: 112, BMI: 312, idealWeight: 82, heightUnit: "cm", weiightUnit: "kg")
}
