//
//  ProgressBarBarView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct ProgressBarBarView: View {

    let percent : Double
    let color : Color
    var body: some View {
        HStack(alignment: .center){
            
            GeometryReader{ geo in
                
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 15.0).fill(color).opacity(0.5).frame(width: geo.size.width, height: 20)
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(color).overlay(content: {
                        if percent > 0.09{
                            Text("% \(Int(percent < 1 ? percent * 100 : 100 ))").font(.caption2).foregroundStyle(.white).frame(maxWidth: .infinity, alignment: .trailing).padding(.horizontal, 5)
                            
                        }
                        
                    }).frame(width: percent < 1 ? geo.size.width * percent : geo.size.width * 1 ,height: 20)
                
            }.clipShape(RoundedRectangle(cornerSize: CGSize(width: geo.size.width - 2, height: 20)))
            }.frame(height: 20)
            
        }.frame(height: 20)
    }
}

#Preview {
    ProgressBarBarView(percent: 0.2, color: .red)
}
