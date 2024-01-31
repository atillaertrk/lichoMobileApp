//
//  BMIbarView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct BMIbarView: View {
    @State private var offset: CGFloat = 0.0
    var percent : Double
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .leading) {
                HStack(spacing: 0){
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing)).frame(width: geo.size.width * 0.35)
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.green]), startPoint: .leading, endPoint: .trailing)).frame(width: geo.size.width * 0.15)
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.orange]), startPoint: .leading, endPoint: .trailing)).frame(width: geo.size.width * 0.30)
                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing)).frame(width: geo.size.width * 0.20)

                }.frame(height: 30)
                Rectangle().fill(.black.opacity(0.3)).frame(width: 1, height: 50).offset(x: geo.size.width * 0.46)
                Rectangle().fill(.black.opacity(0.3)).frame(width: 1, height: 50).offset(x: geo.size.width * 0.625)
                Rectangle().fill(.black.opacity(0.3)) .frame(width: 1, height: 50).offset(x: geo.size.width * 0.75)
                
                HStack(spacing: 0){
                    Text("Underweight").font(.caption2).frame(width: geo.size.width * 0.46).padding(.top, 65)
                    Text("Normal").font(.caption2).frame(width: geo.size.width * 0.165).padding(.bottom, 65)
                    Text("Overweight").font(.caption2).frame(width: geo.size.width * 0.2).padding(.top, 65)
                    Text("Obesity").font(.caption2).frame(width: geo.size.width * 0.15).padding(.bottom, 65)
                }
                Image(systemName: "arrowshape.up.fill").foregroundStyle(.blue).padding(.top, 30).offset(x: self.offset).onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        offset = geo.size.width * percent
                    }}
            }
        }.frame(height: 60)
       
    }
}

#Preview {
    BMIbarView(percent: 0.78)
}
