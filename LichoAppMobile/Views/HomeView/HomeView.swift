//
//  HomeView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    var userid : String
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]
    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }
    }
    @State var percent: CGFloat = 0.0
    @State var lastPercent : CGFloat = 0.0
    var body: some View {
        NavigationStack{
            
                VStack{
                    MainProgressView(caloriesConsumed: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalEnergy"] ?? 0, caloriNeed: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1), kind: "Calori", percent: percent).padding(.horizontal).onAppear{
                        // ----- su listesini sıfırlama
                                    
                        let target = ConvertFuncs.shortDate()
                        profile?.nutrition.removeAll { data in
                            !data.date.contains(target)
                                }
                        self.lastPercent = NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalEnergy"] ?? 0, weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
//
//                        }
                        
                        withAnimation {
                            
                            percent =  self.lastPercent
                        }
                    }

                    
                }
                ScrollView {
                    ProgressBarComplate(color: Color.orange, percent: NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.proteinIntake(weight: profile?.weight ?? 0, dailyActive: ConvertFuncs.activityToString(selectedActivity: profile?.activity ?? 1)), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalProtein"] ?? 0, weight: profile?.weight, height: profile?.height ?? 0) * 0.01, kind: "Protein", dailyIntake: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalProtein"] ?? 0, dailyTarget: NutritionCalculations.proteinIntake(weight: profile?.weight ?? 0, dailyActive: ConvertFuncs.activityToString(selectedActivity: profile?.activity ?? 1)), unit: "g", progressImage: Image("Protein"))
                    
                    
                    
                    ProgressBarComplate(color: Color.brown, percent: NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.carbIntakeAverage(caloriIntake: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalcarbohydrates"] ?? 0, weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01, kind: "Carb", dailyIntake: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalcarbohydrates"] ?? 0, dailyTarget: NutritionCalculations.carbIntakeAverage(caloriIntake: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), unit: "g", progressImage: Image("Carbs"))
                    
                    
                    
                    ProgressBarComplate(color: Color.red, percent: NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.fatIntake(caloriIntake: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalFat"] ?? 0, weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01, kind: "Fat", dailyIntake: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalFat"] ?? 0, dailyTarget: NutritionCalculations.fatIntake(caloriIntake: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), unit: "g", progressImage: Image("Fat"))
             
//   Altta percent hatalı
                    ProgressBarComplate(color: .green, percent: NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.fiberNeed(caloriNeed: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalFiber"] ?? 0, weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01, kind: "Fiber", dailyIntake: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalFiber"] ?? 0, dailyTarget: NutritionCalculations.fiberNeed(caloriNeed: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), unit: "g", progressImage: Image("Fiber"))
                    
                   
                    ProgressBarComplate(color: Color.blue, percent: NutritionCalculations.nutritionPercent(nutritionTarget: profile?.waterGoal ?? 2000, totalAmountOfNutrition: NutritionCalculations.totalConsumedWater(array: profile?.consumedWater ?? []), weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01, kind: "Water", dailyIntake: NutritionCalculations.totalConsumedWater(array: profile?.consumedWater ?? []), dailyTarget: profile?.waterGoal ?? 2000, unit: profile?.volumeUnit ?? "ml", progressImage: Image("Water"))
                   
                    
                    
                    Spacer()
                }
                .onAppear{
  
                    // ----- su listesini sıfırlama
                                
                    let target = ConvertFuncs.shortDate()
                    profile?.consumedWater.removeAll { data in
                        !data.date.contains(target)
                                    }

                    //        -------
                    profile?.nutrition.removeAll { data in
                        !data.date.contains(target)
                            }
                    
                    
                    
                }
                
                .toolbar(content: {
                    ToolbarItem {
                        NavigationLink {
                            SettingsView(userid: userid)
                        } label: {
                            Image(systemName: "gearshape").foregroundStyle(Color.white)
                        }
                        
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Hello \(profile?.userName ?? "")").fontWeight(.light).foregroundStyle(.white)
                    }
                }).toolbarBackground(.visible, for: .navigationBar)
                .toolbarTitleDisplayMode(.inline)
                .toolbarBackground(Color("greenLogo"), for: .navigationBar)
                
            
        }
        
        
            
    }
}

#Preview {
    HomeView(userid: "123")
}

