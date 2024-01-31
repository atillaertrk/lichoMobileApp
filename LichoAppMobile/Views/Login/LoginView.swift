//
//  LoginView.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var ViewModel = LoginViewVM()
    @EnvironmentObject var AuthModel : AuthModel
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()
            }
            VStack{
                if !ViewModel.errMessage.isEmpty{
                    HStack {
                       
                        Image(systemName: "exclamationmark.brakesignal").symbolEffect(.bounce, value: ViewModel.anim)
                        Text(ViewModel.errMessage).lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }.frame(maxWidth: .infinity).foregroundStyle(.orange)
                    
                }
                if !AuthModel.errorMsg.isEmpty{
                    HStack {
                       
                        Image(systemName: "exclamationmark.brakesignal").symbolEffect(.bounce, value: ViewModel.anim)
                        Text(AuthModel.errorMsg).lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }.frame(maxWidth: .infinity).foregroundStyle(.orange)
                    
                }
                TextField("Email Address", text: $ViewModel.email).padding(5).autocorrectionDisabled().textInputAutocapitalization(.never).textFieldStyle(.roundedBorder)
                SecureField("Password", text: $ViewModel.password).padding(5).autocorrectionDisabled().textInputAutocapitalization(.never).textFieldStyle(.roundedBorder)
                ZStack {
                    if ViewModel.progressBool {
                        ProgressView().zIndex(1).tint(Color.white).controlSize(.large).padding(.top)
                    }
                    LargeButtonView(title: "Login", action: {
                        ViewModel.progressBool = true
                        Task{
                            guard  ViewModel.validate() else{
                                ViewModel.progressBool = false
                                return
                            }
                            do{
                                try await AuthModel.login(email: ViewModel.email, password: ViewModel.password)
                                
                                ViewModel.progressBool = false
                            } catch {
                                ViewModel.progressBool = false
                                
                            }
                        }
                        
                    }, color: .greenLogo).padding(.top).disabled(ViewModel.progressBool).disabled(ViewModel.progressBool)
                        
                        
                    
                }
                HStack{
                    Text("Don't have an account?").font(.callout)
                    NavigationLink("Become a member") {
                        
                        SignUpView()
                    }.foregroundStyle(.greenLogo).font(.callout)
                }.padding(.vertical, 10)
                Text("Or").padding(.vertical, 10)
            }.padding(.horizontal)
        }

        }
    }

#Preview {
    LoginView().environmentObject(AuthModel())
}
