//
//  ManuelValuesView.swift
//  LichoAppMobile
//
//  Created by Atilla Ertürk on 31.01.2024.
//

import SwiftUI
import SwiftData

struct ManuelValuesView: View {
   @State var name : String = ""
   @State var calories : String = ""
   @State var fat : String = ""
   @State var sugar: String = ""
   @State var carb : String = ""
   @State var fiber : String = ""
   @State var fat_satured : String = ""
   @State var protein : String = ""
   @State var sodium : String = ""
   @State var potassium : String = ""
   @State var cholesterol : String = ""
    
    
    var userid : String
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]

    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }}
    var body: some View {
        NavigationStack{
            
            ZStack{
               
                Color.greenLogo.ignoresSafeArea(.all)
                VStack{
                    Image("Nutrition").resizable().frame(width: 200, height: 200).padding(0)
                    
                    HStack{
                        Image(systemName: "text.badge.plus").foregroundStyle(.white).font(.title3)
                        Text("Save Nutritional Values").foregroundStyle(.white).font(.title3)
                    }.padding()
                    HStack{
                        
                        VStack{
                            TextField("Nutrition Name", text: $name).textFieldStyle(.roundedBorder).frame(width: 150)
                            TextField("Fat", text: $fat).textFieldStyle(.roundedBorder).frame(width: 150).keyboardType(.decimalPad)
                            TextField("Carb", text: $carb).textFieldStyle(.roundedBorder).frame(width: 150).keyboardType(.decimalPad)
                        }
                        VStack{
                            TextField("Calories", text: $calories).textFieldStyle(.roundedBorder).frame(width: 150).keyboardType(.decimalPad)
                            TextField("Sugar", text: $sugar).textFieldStyle(.roundedBorder).frame(width: 150).keyboardType(.decimalPad)
                            TextField("Fiber", text: $fiber).textFieldStyle(.roundedBorder).frame(width: 150).keyboardType(.decimalPad)
                        }
                    }
                    LargeButtonView(title: "Add", action: {
//Add manuel values and controls
                        
                        let date = ConvertFuncs.shortDate()
                        profile?.nutrition.append(Nutrition(date: date, name: self.name, calories: Double(ConvertFuncs.commaToDotConverter(text: self.calories)) ?? 0, serving_size_g: 0, fat_total_g: Double(ConvertFuncs.commaToDotConverter(text: self.fat)) ?? 0, fat_saturated_g: Double(ConvertFuncs.commaToDotConverter(text: self.fat_satured)) ?? 0, protein_g: Double(ConvertFuncs.commaToDotConverter(text: self.protein)) ?? 0, sodium_mg: Double(ConvertFuncs.commaToDotConverter(text: self.sodium)) ?? 0, potassium_mg: Double(ConvertFuncs.commaToDotConverter(text: self.potassium)) ?? 0, cholesterol_mg: Double(ConvertFuncs.commaToDotConverter(text: self.cholesterol)) ?? 0, carbohydrates_total_g: Double(ConvertFuncs.commaToDotConverter(text: self.carb)) ?? 0, fiber_g: Double(ConvertFuncs.commaToDotConverter(text: self.fiber)) ?? 0, sugar_g: Double(ConvertFuncs.commaToDotConverter(text: self.sugar)) ?? 0))
                        
                    }, color: .grayMode).padding().padding(.horizontal)
                }
            }
            .toolbar{
                ToolbarItem(placement: .keyboard) {
                    HStack{
                        
                        Spacer()
                        Button(action: {
                            UIApplication.shared.endEditing()
                        }, label: {
                            //                        Text("Done")
                            Image(systemName: "arrowtriangle.down.square")
                        }).buttonStyle(.bordered)
                    }
                }
            }
        }
    }
}

#Preview {
    ManuelValuesView(userid: "231")
}
