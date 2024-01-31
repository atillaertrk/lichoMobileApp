//
//  CardView.swift
//  Licho
//
//  Created by Atilla Ertürk on 29.01.2024.
//

import SwiftUI

struct CardView: View {
    var cal : String
    var sugar : String
    var fat : String
    var fiber : String
    var carbonH : String
    var name : String
    var quentity : String
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 25.0).frame(height: 300).zIndex(-1).shadow(radius: 2).foregroundColor(.addButton).shadow(radius: 10)
                VStack {
                    VStack {
                        Text(name).font(.title2).fontWeight(.light)
                        Text(quentity).font(.callout).fontWeight(.light)
                        Divider().background(.silver)
                    }.padding()
                    VStack {
                        HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                            Text("Calorie").frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.regular)
                            Spacer()
                            Text(cal).frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.medium)
                        })
                        Divider().background(.silver)
                        HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                            Text("Sugar").frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.regular)
                            Spacer()
                            Text(sugar).frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.medium)
                        })
                        Divider().background(.silver)
                        HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                            Text("Fat").frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.regular)
                            Spacer()
                            Text(fat).frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.medium)
                        })
                        Divider().background(.silver)
                        HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                            Text("Fiber").frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.regular)
                            Spacer()
                            Text(fiber).frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.medium)
                        })
                        
                        Divider().background(.silver)
                        HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                            Text("Carbonhydrate").frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.regular)
                            Spacer()
                            Text(carbonH).frame(maxWidth: .infinity, alignment: .leading).font(.caption).fontWeight(.medium)
                        })
                        
                    }.padding()
                    Spacer()
                 
                }
                
            }.frame(height: 300).foregroundStyle(.silver)
        }.ignoresSafeArea(.keyboard)
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    CardView(cal: "23", sugar: "0.26", fat: "54", fiber: "21", carbonH: "32", name: "Bread", quentity: "100 g")
}
