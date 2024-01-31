//
//  UserModel.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation

struct UserModel: Codable {
    
    let id : String
    let email : String
    let username : String
    let joiningDate : TimeInterval
    
}
