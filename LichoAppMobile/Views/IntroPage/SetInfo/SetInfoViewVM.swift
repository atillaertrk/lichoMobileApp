//
//  SetInfoViewVM.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation

class SetInfoViewVM : ObservableObject {
    @Published var height = ""
    @Published var heightUnits = ["cm", "inch"]
    @Published var selectedHeightUnit = "cm"
   
    @Published var weight = ""
    @Published var weightUnits = ["kg" , "pound"]
    @Published var selectedWeightUnit = "kg"

    @Published var age = ""

    @Published var genders = ["Prefer not to say","female", "male", "other"]
    @Published var selectedGender = "Prefer not to say"

    @Published var activityLevel = ["Lightly active", "Moderately active", "Active", "Very Active"]
    @Published var selectedActivty = "Moderately active"
    
    @Published var viewError = ""
    
    
    func valideteForm () -> Bool{
        viewError = ""
        guard Double(height.trimmingCharacters(in: .whitespacesAndNewlines)) != nil else {
            viewError = "Please enter a valid height value"
          return false
        }
        guard Double(weight.trimmingCharacters(in: .whitespacesAndNewlines)) != nil else {
            viewError = "Please enter a valid weight value"
          return false
        }
        guard Double(age.trimmingCharacters(in: .whitespacesAndNewlines)) != nil else {
            viewError = "Please enter a valid age value"
          return false
        }
        return true
    }
}
