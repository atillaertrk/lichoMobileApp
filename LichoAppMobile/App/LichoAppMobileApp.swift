//
//  LichoAppMobileApp.swift
//  LichoAppMobile
//
//  Created by Atilla Ertürk on 30.01.2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct LichoAppMobileApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var ViewModel = LichoAppMobileAppVM()
    @State private var isSplashScreenPresented : Bool = true
    @ObservedObject var AuthModelModel = AuthModel()
    var body: some Scene {
        WindowGroup {
            if !isSplashScreenPresented {
                if ViewModel.userId.isEmpty {
                    LoginView()
                } else {
                    if ViewModel.isFirstLogin {
                        IntroPageView(userid: ViewModel.userId)
                        
                    } else {
                        TabBarView(userid: ViewModel.userId)
                    }
                    
                    
                }
            } else {
                SplashScreenView(isPresented: $isSplashScreenPresented)
            }
            
            
        }.environmentObject(AuthModelModel).modelContainer(for : UserInfoSwiftDataModel.self)
    }
}
