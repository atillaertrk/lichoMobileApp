//
//  ConvertFuncs.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import Foundation

struct ConvertFuncs {
    static func commaToDotConverter(text: String) -> String {
        let textDouble = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
        return String(format: "%.2f", textDouble)
    }
    static func shortDate() -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df.string(from: Date())
    }

    static func activityToInt(selectedActivity : String) -> Int {
        if selectedActivity == "Lightly active" {
            return 1
        } else if selectedActivity == "Moderately active" {
            return 2
        } else if selectedActivity == "Active" {
            return 3
        } else if selectedActivity == "Very Active"{
            return 4
        } else {
            return 2
        }
    }
    static func activityToString(selectedActivity : Int) -> String {
        if selectedActivity == 1 {
            return "Lightly active"
        } else if selectedActivity == 2 {
            return "Moderately active"
        } else if selectedActivity == 3 {
            return "Active"
        } else if selectedActivity == 4{
            return "Very Active"
        } else {
            return "Moderately active"
        }
    }
}
