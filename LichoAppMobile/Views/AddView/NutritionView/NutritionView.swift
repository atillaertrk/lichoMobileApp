//
//  NutritionView.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import SwiftUI
import SwiftData

struct NutritionView: View {
    var userid : String
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]

    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }}
    @StateObject var ViewModel = NutritionViewVM()
    var body: some View {

        NavigationStack{
            VStack{
 
                HStack {
                    TextField("\(Image(systemName: "magnifyingglass")) 50g bread, 16.9 oz cola, etc", text: $ViewModel.searchText).ignoresSafeArea(.keyboard, edges: .bottom).keyboardType(.webSearch).italic().padding().font(.callout).foregroundStyle(.grayMode).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.darkgreen, lineWidth:0.5)
                    ).padding(.leading).onSubmit {
                        Task {
                            do {
                                try await ViewModel.getNutrition(food: ViewModel.searchText)
                            } catch {
                                ViewModel.errMsg = error.localizedDescription
                                ViewModel.isAlert = true
                            }
                        }
                }.submitLabel(.search)

                    ZStack{
                        if ViewModel.progress {
                            ProgressView().zIndex(1).tint(Color.black).controlSize(.large)
                        }
                        Button {
                            Task {
                                do {
                                    try await ViewModel.getNutrition(food: ViewModel.searchText)
                                } catch {
                                    ViewModel.errMsg = error.localizedDescription
                                    ViewModel.isAlert = true
                                }
                            }
                        } label: {
                            Image(systemName: "magnifyingglass").padding(.trailing).foregroundStyle(.darkgreen)
                        }.disabled(ViewModel.progress)
                    }
                    

                }.alert("Error", isPresented: $ViewModel.isAlert) {
                    Button("OK") { }
                } message: {
                    Text(ViewModel.errMsg)
                }
                VStack{
                    if ViewModel.energy > 0 || ViewModel.fat > 0 || ViewModel.fiber > 0 || ViewModel.carbohydrates > 0 || ViewModel.sugar > 0 {
                        CardView(cal: String(format: "%.2f", ViewModel.energy), sugar: String(format : "%.2f", ViewModel.sugar), fat: String(format : "%.2f", ViewModel.fat), fiber: String(format : "%.2f", ViewModel.fiber), carbonH: String(format : "%.2f", ViewModel.carbohydrates), name: ViewModel.name, quentity: "\(String(ViewModel.quentity)) g").padding().zIndex(-1)
                        
                        LargeButtonView(title: "+", action: {
                            guard profile != nil else {
                                ViewModel.errMsg = "User data could not be accessed. Try again or log out and try logging in again."
                                ViewModel.isAlert = true
                                return
                            }
                            let date = ConvertFuncs.shortDate()
                            profile?.nutrition.append(Nutrition(date: date, name: ViewModel.name, calories: ViewModel.energy, serving_size_g: ViewModel.quentity, fat_total_g: ViewModel.fat, fat_saturated_g: ViewModel.fatSaturated, protein_g: ViewModel.protein, sodium_mg: ViewModel.sodium, potassium_mg: ViewModel.potassium_mg, cholesterol_mg: ViewModel.cholesterol, carbohydrates_total_g: ViewModel.carbohydrates, fiber_g: ViewModel.fiber, sugar_g: ViewModel.sugar))
                        }, color: Color.addButton).padding(.horizontal)
                        
                    }
                    Button {
                        self.ViewModel.isShowListView.toggle()
                    } label: {
                        Text("\(Image(systemName: "filemenu.and.cursorarrow")) View Daily Log").foregroundStyle(.white).padding(6).padding(.horizontal).background(.greenLogo).clipShape(RoundedRectangle(cornerRadius: 10))
                    }.sheet(isPresented: $ViewModel.isShowListView) {
                        NutritionListView(userid: userid)
                    }.padding(.top)
                    
                }

            }
        }
    }
}

#Preview {
    NutritionView(userid: "123")
}
