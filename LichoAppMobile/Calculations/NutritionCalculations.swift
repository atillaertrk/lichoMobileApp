//
//  NutritionCalculations.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import Foundation

struct NutritionCalculations {
    
    static func totalNutritionValues (NutritionList : [Nutrition]) -> [String : Double]  {
        var totalEnergy = 0.0
        var totalFat = 0.0
        var totalFiber = 0.0
        var totalcarbohydrates = 0.0
        var totalSugar = 0.0
        var totalQuentity = 0.0
        var totalFatSaturated = 0.0
        var totalProtein = 0.0
        var totalSodium = 0.0
        var totalPotassium_mg = 0.0
        var totalCholesterol = 0.0
        for i in NutritionList {
            
            totalEnergy += i.calories
            totalFat += i.fat_total_g
            totalFiber += i.fiber_g
            totalcarbohydrates += i.carbohydrates_total_g
            totalSugar += i.sugar_g
            totalQuentity += i.serving_size_g
            totalFatSaturated += i.fat_saturated_g
            totalProtein += i.protein_g
            totalSodium += i.sodium_mg
            totalPotassium_mg += i.potassium_mg
            totalCholesterol += i.cholesterol_mg
            
            
            
        }
        return [
            "totalEnergy" : totalEnergy, "totalFat" : totalFat, "totalFiber" : totalFiber, "totalcarbohydrates" : totalcarbohydrates,
            "totalSugar" : totalSugar, "totalQuentity" : totalQuentity, "totalFatSaturated" : totalFatSaturated, "totalProtein" : totalProtein,
            "totalSodium" : totalSodium, "totalPotassium_mg " : totalPotassium_mg, "totalCholesterol" : totalCholesterol
        ]
        
    }
//    Nutrition Percent for Graphic
    static func nutritionPercent (nutritionTarget : Double, totalAmountOfNutrition : Double, weight: Double?, height: Double?) -> Double {
        
        let percent = (totalAmountOfNutrition * 100) / nutritionTarget
        if percent <= 100 {
            return percent
        } else if weight == 0 || height == 0 || weight == nil || height == nil {
            return 0
        } else if percent > 100 {
            return 100
        } else {
            return 0
        }
        
    }
//    Amount of Protein to be Taken Daily
    static func proteinIntake (weight: Double, dailyActive : String) -> Double{
        if dailyActive == "Lightly active" {
            return weight * 0.8
        } else if dailyActive == "Moderately active" {
            return weight * 1
        } else if dailyActive == "Active"{
            return weight * 1.3
        } else {
            return weight * 1.5
        }
    }
//    Amount of Fat to be Taken Daily
    static func fatIntake(caloriIntake : Double) -> Double{
        
        let fatPercent = caloriIntake * 0.3
        return fatPercent / 9
    }
    
//    Amount of Carb to be Taken Daily
    static func carbIntake (caloriIntake : Double ) -> [Double] {
        let minCarb = (caloriIntake * 0.45) / 4
        let maxCarb = (caloriIntake * 0.65) / 4
        var carbs : [Double] = []
        carbs.append(minCarb)
        carbs.append(maxCarb)
        carbs.sort()
        return carbs
    }
    static func carbIntakeAverage (caloriIntake : Double ) -> Double {
        let minCarb = (caloriIntake * 0.45) / 4
        let maxCarb = (caloriIntake * 0.65) / 4
        
        return (minCarb + maxCarb) / 2
    }
//    Amount of Calori to be Taken Daily
    static func caloriNeed (bmr: Double, activiteRange : Int) -> Double {
        var caloriNeed : Double
        if activiteRange == 1 {
            caloriNeed = bmr * 1.2
        } else if activiteRange == 2 {
            caloriNeed = bmr * 1.3
        } else if activiteRange == 3 {
            caloriNeed = bmr * 1.4
        } else {
            caloriNeed = bmr * 1.5
        }
        return caloriNeed
    }
}
