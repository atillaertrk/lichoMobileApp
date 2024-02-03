//
//  NutritionViewVM.swift
//  Licho
//
//  Created by Atilla Ertürk on 29.01.2024.
//

import Foundation

class NutritionViewVM : ObservableObject {
    @Published var searchText = ""
    @Published var isShowListView = false
    @Published var isShowManuelView = false
    @Published var isAlert : Bool = false
    
    @Published var errMsg = ""
    @Published var energy = 0.0
    @Published var fat = 0.0
    @Published var fiber = 0.0
    @Published var carbohydrates = 0.0
    @Published var sugar = 0.0
    @Published var progress = false
    @Published var name = ""
    @Published var quentity = 0.0
    
    @Published var fatSaturated = 0.0
    @Published var protein = 0.0
    @Published var sodium = 0.0
    @Published var potassium_mg = 0.0
    @Published var cholesterol = 0.0
    
    func getNutrition(food : String) async throws {
        let query = food.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue("svxr/hD1d50pWdYo185gqQ==8SHv6thcObd6Bic6", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                // JSON dizisini oluştur
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    
                    // JSON dizisini kullanabilirsin
                    print(jsonArray)
                    DispatchQueue.main.async {
                        for item in jsonArray {
                            self.name = item["name"] as? String ?? ""
                            self.energy = item["calories"] as? Double ?? 0.0
                            self.fat = item["fat_total_g"] as? Double ?? 0.0
                            self.fiber = item["fiber_g"] as? Double ?? 0.0
                            self.carbohydrates = item["carbohydrates_total_g"] as? Double ?? 0.0
                            self.sugar = item["sugar_g"] as? Double ?? 0.0
                            self.quentity = item["serving_size_g"] as? Double ?? 0.0
                            self.cholesterol = item["cholesterol_mg"] as? Double ?? 0.0
                            self.sodium = item["sodium_mg"] as? Double ?? 0.0
                            self.potassium_mg = item["potassium_mg"] as? Double ?? 0.0
                            self.fatSaturated = item["fat_saturated_g"] as? Double ?? 0.0
                            self.protein = item["protein_g"] as? Double ?? 0.0
                            print(self.cholesterol, self.potassium_mg, self.sodium, self.protein, self.fatSaturated)
                        }
                    }
                    
                    
                } else {
                    print("Invalid JSON format")
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
