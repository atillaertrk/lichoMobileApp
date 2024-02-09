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
    @Environment(\.dismiss) var dismiss
    var body: some View {

        NavigationStack{
            
            ScrollView{
                ZStack{
                    
                    VStack{
                        Divider()
                        if ViewModel.emptyList {
                            HStack{
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.callout)
                                    .padding(10)
                                    .foregroundStyle(.orange)
                                Text("The food you were looking for was not found")
                                    .font(.callout)
                                    .foregroundStyle(.homeOrange)
                                    .padding(.vertical).padding(.trailing)
                            }.background(.thinMaterial).padding()
                        } else {
                            Image(systemName: "frying.pan").font(.system(size: 50)).foregroundStyle(.homeOrange).padding()
                        }
                        HStack {
                            TextField("\(Image(systemName: "magnifyingglass")) a slice of pizza, 16.9 oz cola, etc", text: $ViewModel.searchText).ignoresSafeArea(.keyboard, edges: .bottom).keyboardType(.webSearch).italic().padding().font(.callout)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                    
                                        .stroke(Color.darkgreen, lineWidth:1)
                                    
                                ).padding(.leading).onSubmit {
                                    ViewModel.emptyList = false
                                    
                                    Task {
                                        do {
                                            try await ViewModel.getNutrition(food: ViewModel.searchText)
                                            ViewModel.searchText = ""
                                            
                                            
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
                                    ViewModel.emptyList = false
                                    Task {
                                        do {
                                            try await ViewModel.getNutrition(food: ViewModel.searchText)
                                            ViewModel.searchText = ""
                                            
                                        } catch {
                                            ViewModel.errMsg = error.localizedDescription
                                            ViewModel.isAlert = true
                                        }
                                    }
                                } label: {
                                    Image(systemName: "magnifyingglass").padding(.trailing).foregroundStyle(.darkgreen)
                                }.disabled(ViewModel.progress)
                            }
                            
                            
                        }.padding(.horizontal).padding(.bottom).alert("Error", isPresented: $ViewModel.isAlert) {
                            Button("OK") { }
                        } message: {
                            Text(ViewModel.errMsg)
                        }
                        HStack{
                            Image(systemName: "minus").resizable().frame(height: 1)
                            Text("OR").foregroundStyle(.softBlack)
                            Image(systemName: "minus").resizable().frame(height: 1)
                        }.padding(.horizontal, 30).padding(20)
                        
                        VStack{
                            
                            Button(action: {
                                ViewModel.isShowManuelView = true
                            }, label: {
                                Text("Manual Registration").foregroundStyle(.addButton).padding(5)
                            }).sheet(isPresented: $ViewModel.isShowManuelView) {
                                ManuelValuesView(userid: self.userid).presentationDetents([.fraction(0.65)])
                                
                            }
                        }
                        Divider()
                        VStack{
                            if ViewModel.energy > 0 || ViewModel.fat > 0 || ViewModel.fiber > 0 || ViewModel.carbohydrates > 0 || ViewModel.sugar > 0 {
                                CardView(cal: String(format: "%.2f", ViewModel.energy), sugar: String(format : "%.2f", ViewModel.sugar), fat: String(format : "%.2f", ViewModel.fat), fiber: String(format : "%.2f", ViewModel.fiber), carbonH: String(format : "%.2f", ViewModel.carbohydrates), name: ViewModel.name, quentity: "\(String(format: "%.2f", ViewModel.quentity)) g").padding(5).zIndex(-1)
                                
                                LargeButtonView(title: "+", action: {
                                    guard profile != nil else {
                                        ViewModel.errMsg = "User data could not be accessed. Try again or log out and try logging in again."
                                        ViewModel.isAlert = true
                                        return
                                    }
                                    let date = ConvertFuncs.shortDate()
                                    profile?.nutrition.append(Nutrition(date: date, name: ViewModel.name, calories: ViewModel.energy, serving_size_g: ViewModel.quentity, fat_total_g: ViewModel.fat, fat_saturated_g: ViewModel.fatSaturated, protein_g: ViewModel.protein, sodium_mg: ViewModel.sodium, potassium_mg: ViewModel.potassium_mg, cholesterol_mg: ViewModel.cholesterol, carbohydrates_total_g: ViewModel.carbohydrates, fiber_g: ViewModel.fiber, sugar_g: ViewModel.sugar))
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        //
                                    }
                                }, color: Color.addButton).padding()
                                
                            }
                            
                            Button {
                                self.ViewModel.isShowListView.toggle()
                            } label: {
                                Text("\(Image(systemName: "filemenu.and.cursorarrow")) View Daily Log").foregroundStyle(.white).padding(6).padding(.horizontal).background(.greenLogo).clipShape(RoundedRectangle(cornerRadius: 10))
                            }.sheet(isPresented: $ViewModel.isShowListView) {
                                HStack{
                                    NutritionListView(userid: userid).presentationDetents([.fraction(0.85)])
                                }
                                
                            }.padding(25)
                            Rectangle().foregroundStyle(.clear).frame(height: 30)
                            Spacer()
                        }
                        
                    }
                }
            }.background(Color.standartBacground.ignoresSafeArea()).navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                          
//                            HStack{
//                                Image(systemName: "chevron.backward.2").foregroundStyle(.addButton)
//                                Text("Add Screen").font(.system(size: 18)).fontWidth(.expanded).foregroundStyle(.addButton)
//                            }
                            Text("\(Image(systemName: "chevron.backward.2")) Add Screen").foregroundStyle(.addButton).font(.system(size: 18)).background(.clear)
                            
                        }
                    }
                    
                }}
    }
}

#Preview {
    NutritionView(userid: "123")
}
