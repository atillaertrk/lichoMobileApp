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
            ScrollView{
                VStack{
                    MainProgressView(caloriesConsumed: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalEnergy"] ?? 0, caloriNeed: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1), kind: "Calori", percent: percent).padding(.horizontal).padding(.top, 50).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation {
                                
                                percent =  self.lastPercent
                            }
                        }
                        
                    }
                    ProgressBarComplate(color: Color.orange, percent: NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.proteinIntake(weight: profile?.weight ?? 0, dailyActive: ConvertFuncs.activityToString(selectedActivity: profile?.activity ?? 1)), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalProtein"] ?? 0, weight: profile?.weight, height: profile?.height ?? 0) * 0.01, kind: "Protein", dailyIntake: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalProtein"] ?? 0, dailyTarget: NutritionCalculations.proteinIntake(weight: profile?.weight ?? 0, dailyActive: ConvertFuncs.activityToString(selectedActivity: profile?.activity ?? 1)), unit: "g", progressImage: Image("Protein"))
                    
                    
                    
                    ProgressBarComplate(color: Color.brown, percent: NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.carbIntakeAverage(caloriIntake: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalcarbohydrates"] ?? 0, weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01, kind: "Carb", dailyIntake: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalcarbohydrates"] ?? 0, dailyTarget: NutritionCalculations.carbIntakeAverage(caloriIntake: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1)), unit: "g", progressImage: Image("Carbs"))
                    
                    
                    
                    ProgressBarComplate(color: Color.blue, percent: NutritionCalculations.nutritionPercent(nutritionTarget: profile?.waterGoal ?? 2000, totalAmountOfNutrition: profile?.consumedWaterInt ?? 0, weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01, kind: "Water", dailyIntake: profile?.consumedWaterInt ?? 0, dailyTarget: profile?.waterGoal ?? 2000, unit: "ml", progressImage: Image("Water"))
                    LargeButtonView(title: "Check out other nutritional facts   >>>", action: {
                        
                    }, color: Color.greenLogo).padding(.horizontal).padding(.vertical).padding(.bottom)
                    Spacer()
                    
                }.onAppear{
                    self.lastPercent = NutritionCalculations.nutritionPercent(nutritionTarget: NutritionCalculations.caloriNeed(bmr: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 20, gender: profile?.gender ?? "male"), activiteRange: profile?.activity ?? 1), totalAmountOfNutrition: NutritionCalculations.totalNutritionValues(NutritionList: profile?.nutrition ?? [])["totalEnergy"] ?? 0, weight: profile?.weight ?? 0, height: profile?.height ?? 0) * 0.01

                    
                }.toolbar(content: {
                    ToolbarItem {
                        NavigationLink {
                            SettingsView(userid: userid)
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Hello \(profile?.userName ?? "")")
                    }
                }).toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}

#Preview {
    HomeView(userid: "123")
}

