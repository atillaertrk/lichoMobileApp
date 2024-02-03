//
//  NutritionListView.swift
//  Licho
//
//  Created by Atilla Ertürk on 29.01.2024.
//

import SwiftUI
import SwiftData

struct NutritionListView: View {
    @StateObject var ViewModel = NutritionViewVM()
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]
    let userid : String
    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }
    }
    var body: some View {
        VStack{
//            if profile != nil {
                VStack{
                    TotalCardView(calories: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalEnergy"] ?? 0, fat: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalFat"] ?? 0, sugar: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalSugar"] ?? 0, carb: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalcarbohydrates"] ?? 0, fiber: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalFiber"] ?? 0, fat_satured: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalFatSaturated"] ?? 0, protein: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalProtein"] ?? 0, sodium: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalSodium"] ?? 0, potassium: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalPotassium_mg"] ?? 0, cholesterol: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalCholesterol"] ?? 0)

                }.padding(.horizontal).padding(.top)
//            }

            if profile != nil {
                List {
                    ForEach(profile!.nutrition, id: \.self) { i in
                        NutritionListCard(nameQuantitiy: "\(String(format: "%.2f", i.serving_size_g))g \(i.name) ", fat: i.fat_total_g, cal: i.calories, sugar: i.sugar_g, carb: i.carbohydrates_total_g)
                        
                    
                                    }.onDelete(perform: { indexSet in
                                        indexSet .forEach { index in
                                            let data = profile?.nutrition[index]
                                            context.delete(data!)
                                            do{
                                                try context.save()
                                            } catch{
                    
                                            }
                                        }
                                    })
                }.scrollContentBackground(.hidden)
            }
            
        }.padding(.top).onAppear{
            
                        
            let target = ConvertFuncs.shortDate()
            profile?.nutrition.removeAll { data in
                !data.date.contains(target)
                    }

            
        }
    }
}

#Preview {
    NutritionListView( userid: "123")
}
