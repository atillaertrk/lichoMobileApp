//
//  LoginViewVM.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation
class LoginViewVM : ObservableObject {
   
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var errMessage : String = ""
    @Published var anim : Bool = true
    @Published var progressBool : Bool = false
    
    init(){}
    
    
    
    private func isValidEmail(email : String) -> Bool {
            let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
            return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
        }
    
    func validate()-> Bool{
        self.errMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            errMessage = "Please fill in all fields"
            self.anim.toggle()
            return false
        }
        
        guard isValidEmail(email: email) else {
            self.anim.toggle()
            errMessage = "Email address is invalid"
            return false
        }
        guard password.count > 5 else {
            self.anim.toggle()
            errMessage = "Password must be at least 6 characters"
            return false
        }
        return true
    }
}
