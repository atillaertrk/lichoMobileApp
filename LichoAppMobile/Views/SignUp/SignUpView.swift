//
//  SignUpView.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    @StateObject var ViewModel = SignUpViewVM()
    @EnvironmentObject var AuthModel : AuthModel
    @Environment (\.modelContext) private var context
    var body: some View {
        VStack {
            HeaderView()
        
        if !ViewModel.errMessage.isEmpty{
            HStack{
                
                Image(systemName: "exclamationmark.brakesignal").symbolEffect(.bounce, value: ViewModel.anim)
                Text(ViewModel.errMessage).lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
            }.frame(maxWidth: .infinity).foregroundStyle(.orange)
            
        }
            if !AuthModel.errorMsg.isEmpty{
                HStack{
                    
                     Image(systemName: "exclamationmark.brakesignal").symbolEffect(.bounce, value: ViewModel.anim)
                    Text(AuthModel.errorMsg).lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                     
                 }.frame(maxWidth: .infinity).foregroundStyle(.orange)
            }
            TextField("Email Address", text: $ViewModel.email).padding(5).autocorrectionDisabled().textInputAutocapitalization(.never).textFieldStyle(.roundedBorder)
            TextField("Username", text: $ViewModel.username).padding(5).autocorrectionDisabled().textInputAutocapitalization(.never).textFieldStyle(.roundedBorder)
            SecureField("Password", text: $ViewModel.password).padding(5).autocorrectionDisabled().textInputAutocapitalization(.never).textFieldStyle(.roundedBorder)
            ZStack{
                if ViewModel.progressBool {
                    ProgressView().zIndex(1).tint(Color.white).controlSize(.large)
                }
                
                
//                CREATE ACCOUNT BUTTON
                
                
                LargeButtonView(title: "Create Account", action: {
                    Task{
//                        UserDefaults.standard.set(true, forKey: "isFirstLogin")
                        UserDefaults.standard.isFirstLogin = true

                        ViewModel.progressBool = true
                        guard  ViewModel.validate() else{
                            ViewModel.progressBool = false
                            return }
                        do{
                            try await AuthModel.createUser(email:ViewModel.email, password: ViewModel.password,  username: ViewModel.username)
                            let user_id = AuthModel.data["id"]
                            guard let user_id else {return}
                            let user = UserInfoSwiftDataModel(userId: user_id as? String, userName: ViewModel.username, email: ViewModel.email)
                            context.insert(user)
                            try context.save()
                            ViewModel.progressBool = false
                        } catch {
                            ViewModel.progressBool = false
                            print("HATA")
                            print(error.localizedDescription)
                        }
                    }
                    
                }, color: .greenLogo).padding(.vertical, 20).disabled(ViewModel.progressBool)
            }
        }.padding(.horizontal)
        
    }
}

#Preview {
    SignUpView().environmentObject(AuthModel()).modelContainer(for : UserInfoSwiftDataModel.self)
}
