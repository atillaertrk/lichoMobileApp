//
//  ProgressBarComplate.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct ProgressBarComplate: View {
    let color : Color
    let percent : Double
    let kind : String
    let dailyIntake : Double
    let dailyTarget : Double
    let unit : String
    let progressImage : Image
    var body: some View {
            HStack {
                progressImage.resizable().frame(width: 100, height:71).foregroundStyle(color).shadow(radius:2).padding(.leading)
                    VStack {
                        HStack {
                            Text(kind).fontWeight(.semibold).font(.headline).padding(.horizontal, 20)
                            Spacer()
                            Text("\(String(format: "%.1f", dailyIntake)) \(unit)").fontWeight(.semibold).font(.headline).padding(.horizontal, 20)
                                    }.padding(.top, 15)
                            ProgressBarBarView(percent: self.percent, color: self.color)
                            .padding(.horizontal, 20)
                            HStack{
                                Text("0 \(unit)").font(.caption).foregroundStyle(.gray).padding(.horizontal, 20)
                                Spacer()
                                Text("\(String(format: "%.1f", dailyTarget))  \(unit)").font(.caption).foregroundStyle(.gray).padding(.horizontal, 20)
                                        }.padding(.bottom, 10)
                                    }
                                }.background(color.opacity(0.2)).clipShape(RoundedRectangle(cornerRadius: 25.0)).padding(.horizontal)
    }
}

#Preview {
    ProgressBarComplate(color: .pink, percent: 0.34, kind: "Protein", dailyIntake: 27.6, dailyTarget: 38, unit: "g", progressImage: Image("Protein"))
}
