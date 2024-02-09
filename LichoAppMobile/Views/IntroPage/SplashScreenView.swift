//
//  SplashScreenView.swift
//  LichoAppMobile
//
//  Created by Atilla Ertürk on 8.02.2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var circleScale = CGSize(width: 0, height: 0)
    @State private var logoOpacity = 0.7
    @State private var circleOpacity = 1
    @Binding var isPresented : Bool
    var body: some View {
        ZStack{
            Color.greenLogo.ignoresSafeArea()
            ZStack{
                Circle()
                    .foregroundStyle(.smokeWhite)
                    .frame(width: 10)
                    .opacity(Double(circleOpacity))
                    .scaleEffect(circleScale)
                    
                Image("logo-dark")
                    .opacity(Double(logoOpacity))
                
            }.scaleEffect(scale)
        }.onAppear{
            withAnimation(.easeInOut(duration: 3.5)){
                scale = CGSize(width: 0.9, height: 0.9)
                logoOpacity = 1
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5 , execute: {
                withAnimation(.easeIn(duration: 0.35)){
                    circleOpacity = 1
                    circleScale = CGSize(width: 200, height: 200)
                    self.isPresented = false
                    
                }
            })
        }
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
