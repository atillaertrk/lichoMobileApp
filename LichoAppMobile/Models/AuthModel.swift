//
//  AuthModel.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation
import Firebase

@MainActor
class AuthModel : ObservableObject{
    @Published var errorMsg = ""
    @Published var userSession : FirebaseAuth.User?
    @Published var data = [:]
   
    
//    FETCH USER
    
    
    func fetchUser() async throws{
        self.errorMsg = ""
        let db = Firestore.firestore()
        do {
            if let userID = Auth.auth().currentUser?.uid {
                self.data = try await db.collection("users").document(userID).getDocument().data() ?? [:]
                print("fetchuser çalıştı")
                
            }
            
        } catch {
            self.errorMsg = error.localizedDescription
        }
        
    }
    
//    CREATE USER
    
    func createUser(email: String, password : String, username: String) async throws{
        self.errorMsg = ""
        do{
            try await Auth.auth().createUser(withEmail: email, password: password)
            if let id = Auth.auth().currentUser?.uid {
                let userExist = try await isUserSaved(id: id)
                if !userExist {
                    try await saveToNewUser(id: id, email: email, username: username)
                    try await fetchUser()
                } else{
                    print("kullanıcı var")
                }
            }
        } catch {
            self.errorMsg = error.localizedDescription
        }
    }
//    LOGIN
    
    func login (email:String, password: String) async throws {
        self.errorMsg = ""
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = Auth.auth().currentUser
            try await fetchUser()
            if let userId = userSession?.uid {
                let userExist = try await isUserSaved(id: userId)
                if !userExist {
                    try await saveToNewUser(id: userId, email: email, username: "")
                    try await fetchUser()
                } else{
                    print("kullanıcı var")
                }
            }
        }catch{
            self.errorMsg = error.localizedDescription
        }
    }
    
//    IS USER SAVED ON FIREBASE
    
    private func isUserSaved (id: String) async throws -> Bool {
        let db = Firestore.firestore()
        do {
            let document = try await db.collection("users").document(id).getDocument()
            return document.exists
        }catch {
            return false
        }
        
        
    }
    
//    SAVE NEW USER TO FIREBASE
    private func saveToNewUser(id: String, email : String, username : String) async throws{
        self.errorMsg = ""
        let db = Firestore.firestore()
        let user = UserModel(id: id, email: email, username: username, joiningDate: Date.timeIntervalBetween1970AndReferenceDate)
        
        do{
            try await db.collection("users").document(id).setData(user.asDictionary())
        } catch {
            self.errorMsg = error.localizedDescription
            try await Auth.auth().currentUser?.delete()
            self.userSession = nil
        }
        
        
    }
    
    
}
