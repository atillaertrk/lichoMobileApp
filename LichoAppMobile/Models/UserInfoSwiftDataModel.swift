//
//  UserInfoSwiftDataModel.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation
import SwiftData

@Model
final class UserInfoSwiftDataModel {
    
    @Attribute(.unique) var userId : String?
    var userName : String?
    var email : String?
    var height: Double?
    var heightUnit: String?
    var weight: Double?
    var weightUnit: String?
    var gender: String?
    var waterGoal: Double?
    var consumedWater = [Water]()
    var consumedWaterInt : Double?
    var volumeUnit: String?
    var activity: Int?
    var age : Int?
    var nutrition = [Nutrition]()
    var isPro : Bool?

    
    init(userId: String? = nil, userName: String? = nil, email: String? = nil, height: Double? = nil, heightUnit: String? = nil, weight: Double? = nil, weightUnit: String? = nil, gender: String? = nil, waterGoal: Double? = nil, consumedWater: [Water] = [Water](), consumedWaterInt: Double? = nil, volumeUnit: String? = nil, activity: Int? = nil, age: Int? = nil, nutrition: [Nutrition] = [Nutrition](), isPro : Bool? = nil) {
        print("model başlatıldı")
        self.userId = userId
        self.userName = userName
        self.email = email
        self.height = height
        self.heightUnit = heightUnit
        self.weight = weight
        self.weightUnit = weightUnit
        self.gender = gender
        self.waterGoal = waterGoal
        self.consumedWater = consumedWater
        self.consumedWaterInt = consumedWaterInt
        self.volumeUnit = volumeUnit
        self.activity = activity
        self.age = age
        self.nutrition = nutrition
        self.isPro = isPro
    }
    


}

@Model
final class Water {
    var date: String
    var consumed : Double
    var unit : String
    var User : UserInfoSwiftDataModel?
    
    init(date: String, consumed: Double, unit:String, User: UserInfoSwiftDataModel? = nil) {
        self.date = date
        self.consumed = consumed
        self.unit = unit
        self.User = User
        
    }
}

@Model
final class Nutrition{
    var date : String
    var name: String
    var calories: Double
    var serving_size_g: Double
    var fat_total_g: Double
    var fat_saturated_g: Double
    var protein_g: Double
    var sodium_mg: Double
    var potassium_mg: Double
    var cholesterol_mg: Double
    var carbohydrates_total_g: Double
    var fiber_g: Double
    var sugar_g: Double
    var User : UserInfoSwiftDataModel?
    
    init(date: String, name: String, calories: Double, serving_size_g: Double, fat_total_g: Double, fat_saturated_g: Double, protein_g: Double, sodium_mg: Double, potassium_mg: Double, cholesterol_mg: Double, carbohydrates_total_g: Double, fiber_g: Double, sugar_g: Double, User: UserInfoSwiftDataModel? = nil) {
        self.date = date
        self.name = name
        self.calories = calories
        self.serving_size_g = serving_size_g
        self.fat_total_g = fat_total_g
        self.fat_saturated_g = fat_saturated_g
        self.protein_g = protein_g
        self.sodium_mg = sodium_mg
        self.potassium_mg = potassium_mg
        self.cholesterol_mg = cholesterol_mg
        self.carbohydrates_total_g = carbohydrates_total_g
        self.fiber_g = fiber_g
        self.sugar_g = sugar_g
        self.User = User
    }
    
    
}
