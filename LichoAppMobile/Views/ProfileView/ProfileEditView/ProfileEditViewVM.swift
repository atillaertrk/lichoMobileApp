//
//  ProfileEditViewVM.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import Foundation

class ProfileEditViewVM : ObservableObject {
    @Published var heightUnits = ["cm", "inch"]
    @Published var volumeUnits = ["ml", "fl oz (UK)", "fl oz (US)"]
    @Published var weightUnits = ["kg" , "pound"]
    @Published var genders = ["Prefer not to say", "female", "male", "other"]
    @Published var selectedGender = "Prefer not to say"
    @Published var activityLevel = ["Lightly active", "Moderately active", "Active", "Very Active"]
    @Published var selectedActivity = "Moderately active"
    @Published var userHeight : String = ""
    @Published var selectedHeightUnit = "cm"
    @Published var selectedVolumeUnit = "ml"
    @Published var userWeight : String = ""
    @Published var selectedWeightUnit = "kg"
    @Published var waterGoal = "0"
    @Published var age = ""
    @Published var active : Bool = true
    @Published var checkMark : Bool = false
    @Published var xCircle : Bool = false
    @Published var alertBool = false
    @Published var errMSG = ""
    @Published var animation : Bool = false
}
