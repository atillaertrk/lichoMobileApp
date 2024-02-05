//
//  MainProgressView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct MainProgressView: View {
    let caloriesConsumed : Double
    let caloriNeed : Double
    let kind : String
    var percent: CGFloat
    var body: some View {
        

        VStack {
        
            ZStack{
                
                HomeGraphic(percent: percent).stroke(lineWidth: 20).fill(LinearGradient(colors: [Color.addButton, Color.purple, Color.red], startPoint: .leading, endPoint: .trailing)).shadow(radius: 5).opacity(1).padding( .bottom, -250).padding(.horizontal, 30).padding(.top, -100)
                HomeGraphic(percent: 1).stroke(lineWidth: 20).fill(LinearGradient(colors: [Color.addButton, Color.purple, Color.red], startPoint: .leading, endPoint: .trailing)).opacity(0.4).padding( .bottom, -250).padding(.horizontal, 30).padding(.top, -100)
                
                VStack {
                    Text("Calori Intake").fontWidth(.expanded).font(.title2)
                    if percent != 0 {
                        Text("\(String(format: "%.f", percent * 100))%").fontWidth(.expanded).font(.title)
                        Text("\(String(format:"%.2f" ,caloriesConsumed)) kcal")
                    } else {
                        Text("0%").fontWidth(.expanded).font(.title)
                        Text("0 kcal")
                    }
                    
                }.padding(.top, 80)
                
            }.frame(maxHeight: 230)
            HStack{
                Text("0").fontWidth(.expanded).font(.title3).foregroundStyle(.grayMode)
                Spacer()
                Text(String(format: "%.1f", caloriNeed)).fontWidth(.expanded).font(.title3).foregroundStyle(.grayMode)
            }.padding(.horizontal).padding(.top, -40)
        }
    }
}
struct HomeGraphic: Shape {
    var percent: CGFloat
    var animatableData: CGFloat {
            get { percent }
            set { percent = newValue }
        }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let startAngle = Angle(degrees: -180)
        let endAngle = Angle(degrees: 180 * (percent) - 180)
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
 
        return path
    }
}
#Preview {
    MainProgressView(caloriesConsumed: 123.42321, caloriNeed: 12341, kind: "Calorie", percent: 0.92)
}
