//
//  SignUpViewVM.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation

class SignUpViewVM : ObservableObject{
    @Published var email : String = ""
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var errMessage :String = ""
    @Published var anim : Bool = false
    @Published var progressBool : Bool = false
    
    
    func validate()-> Bool{
        self.errMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            errMessage = "Please fill in all fields"
            self.anim.toggle()
            return false
        }
        func isValidEmail(email : String) -> Bool {
                let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
                return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
            }
        guard isValidEmail(email: email) else{
            self.anim.toggle()
            errMessage = "Email address is invalid"
            return false
        }
        guard username.count > 2 else {
            self.anim.toggle()
            errMessage = "Username must be at least 6 characters"
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
