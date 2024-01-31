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
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    MainProgressView(caloriesConsumed: 148, caloriNeed: 1480, kind: "Calori", percent: percent).padding(.horizontal).padding(.top, 50).onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation {
                                
                                percent = 0.4
                            }
                        }
                        
                    }
                    ProgressBarComplate(color: Color.orange, percent: 0.3, kind: "Protein", dailyIntake: 137, dailyTarget: 1248, unit: "mg", progressImage: Image("Protein"))
                    ProgressBarComplate(color: Color.brown, percent: 0.25, kind: "Carb", dailyIntake: 540, dailyTarget: 2749, unit: "mg", progressImage: Image("Carbs"))
                    ProgressBarComplate(color: Color.blue, percent: 0.80, kind: "Water", dailyIntake: 3021, dailyTarget: 4000, unit: "ml", progressImage: Image("Water"))
                    LargeButtonView(title: "Check out other nutritional facts   >>>", action: {
                        
                    }, color: Color.greenLogo).padding(.horizontal).padding(.vertical).padding(.bottom)
                    Spacer()
                    //                    Text("Username : \(profile?.userName ?? "")")
                    //                    Text("user email : \(profile?.email ?? "")")
                    //                    Text("user id : \(profile?.userId ?? "")")
                    //                    Text("height : \(String( format: "%.2f" ,profile?.height ?? 0))")
                    //                    Text("weight : \(String( format: "%.2f" ,profile?.weight ?? 0))")
                    //                    Text("age : \(String(profile?.age ?? 0))")
                    
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

