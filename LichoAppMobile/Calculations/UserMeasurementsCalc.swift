//
//  UserMeasurementsCalc.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import Foundation

struct UserMeasurementsCalc {
    
//    Ideal Weight
    static func idealWeight(height: Double, weightUnit: String, heightUnit: String, gender: String) -> Double {
        var idealW : Double
        if heightUnit == "cm" {
            if gender == "male" {
                if weightUnit == "kg" {
                    idealW = 50 + ( 0.91 * (height - 152.4) )
                } else {
                    idealW = (50 + ( 0.91 * (height - 152.4) )) * 2.20462262
                }
                
            } else if gender == "female" {
                if weightUnit == "kg" {
                    idealW = 45.5 + (0.91 * (height - 152.4 ))
                } else {
                    idealW = (45.5 + (0.91 * (height - 152.4 ))) * 2.20462262
                }
                
            } else {
                if weightUnit == "kg" {
                    idealW = 47.8 + ( 0.91 * (height - 152.4))
                } else{
                    idealW = 47.8 + ( 0.91 * (height - 152.4)) * 2.20462262
                }
                
            }
        } else {
            if gender == "male" {
                if weightUnit == "kg" {
                    idealW = (50 + ( 0.91 * ((height * 2.54 ) - 152.4) ) )
                } else {
                    idealW = (50 + ( 0.91 * ((height * 2.54 ) - 152.4) ) ) * 2.20462262
                }
                
            } else if gender == "female" {
                if weightUnit == "kg" {
                    idealW = (45.5 + (0.91 * ((height * 2.54 ) - 152.4 )))
                } else {
                    idealW = (45.5 + (0.91 * ((height * 2.54 ) - 152.4 ))) * 2.20462262
                }
                
            } else {
                if weightUnit == "kg" {
                    idealW = (47.8 + ( 0.91 * ((height * 2.54 ) - 152.4)))
                } else {
                    idealW = (47.8 + ( 0.91 * ((height * 2.54 ) - 152.4))) * 2.20462262
                }
                
            }
        }
        
        return idealW
    }
    
//    BMR Calculate
    static func calculateBMR(height: Double, heightUnit: String, weightUnit: String, weight: Double, age: Int, gender : String) -> Double {
        
        var BMR : Double
        if heightUnit == "cm" {
            
            if gender == "female"{
                if weightUnit == "kg" {
                    BMR = (10 * Double(weight)) + (6.25 * Double(height)) - (5 * Double(age)) - 161
                } else {
                    BMR = (10 * Double(weight * 0.45359237)) + (6.25 * Double(height)) - (5 * Double(age)) - 161
                }
                
            } else if gender == "male" {
                if weightUnit == "kg" {
                    BMR = (10 * Double(weight)) + (6.25 * Double(height)) - (5 * Double(age)) + 5
                } else {
                    BMR = (10 * Double(weight * 0.45359237)) + (6.25 * Double(height)) - (5 * Double(age)) + 5
                }
               
            } else{
                if weightUnit == "kg" {
                    BMR = (10 * Double(weight)) + (6.25 * Double(height)) - (5 * Double(age)) - 88
                } else {
                    BMR = (10 * Double(weight * 0.45359237)) + (6.25 * Double(height)) - (5 * Double(age)) - 88
                }
                
            }
            
        } else {
            if gender == "female"{
                if weightUnit == "kg" {
                    BMR = (10 * Double((weight))) + (6.25 * Double((height * 2.54 ))) - (5 * Double(age)) - 161
                } else {
                    BMR = (10 * Double((weight * 0.45359237))) + (6.25 * Double((height * 2.54 ))) - (5 * Double(age)) - 161
                }
                
            } else if gender == "male" {
                if weightUnit == "kg" {
                    BMR = (10 * Double((weight))) + (6.25 * Double((height * 2.54 ))) - (5 * Double(age)) + 5
                } else {
                    BMR = (10 * Double((weight * 0.45359237))) + (6.25 * Double((height * 2.54 ))) - (5 * Double(age)) + 5
                }
                
            } else{
                if weightUnit == "kg" {
                    BMR = (10 * Double((weight))) + (6.25 * Double((height * 2.54 ))) - (5 * Double(age)) - 88
                } else {
                    BMR = (10 * Double((weight * 0.45359237))) + (6.25 * Double((height * 2.54 ))) - (5 * Double(age)) - 88
                }
                
            }
            
        }
        return BMR < 0 ? 0 : BMR
        
    }

//    BMI Calculate
    static func calculateBmi(height: Double, weight: Double, heightUnit : String, weightUnit: String) -> Double {
        var bmiresult : Double
        if heightUnit == "cm" {
            if weightUnit == "kg" {
                bmiresult = weight / ((height / 100) * ( height/100) )
            } else {
                bmiresult = (weight * 0.45359237) / (((height) / 100) * ( (height * 2.54 ) / 100) )
            }
            
        } else {
            if weightUnit == "kg" {
                bmiresult = (weight) / (((height * 2.54 ) / 100) * ( (height * 2.54 ) / 100) )
            } else {
                bmiresult = (weight * 0.45359237) / (((height * 2.54 ) / 100) * ( (height * 2.54 ) / 100) )
            }
            
        }
        return bmiresult < 0 ? 0 : bmiresult
        
    }
    
}
