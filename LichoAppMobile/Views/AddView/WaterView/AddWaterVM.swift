//
//  AddWaterVM.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import Foundation

class AddWaterVM : ObservableObject {
    @Published var totalConsumedML = 0.0
    @Published var totalConsumedFloz = 0.0
    
    @Published var other : String = ""
    @Published var waterGoal : String = ""
    
    @Published var errMsg : String = ""
    @Published var errTitle : String = ""
    @Published var isAlert : Bool = false
    
    func totalConsumedWaterML(array: [Water]) {
        var totalConsumed = 0.0
        for i in array {
            totalConsumed += i.consumed
        }
        self.totalConsumedML = totalConsumed
        
    }
    func totalConsumedWaterFloz(array: [Water]) {
        var totalConsumed = 0.0
        for i in array {
            totalConsumed += i.consumed
        }
        self.totalConsumedFloz = totalConsumed
        
    }
}
