//
//  WaterView.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import SwiftUI
import SwiftData

struct WaterView: View {
    var userid : String
    @StateObject var ViewModel = AddWaterVM()
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]

    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }
    }
    var body: some View {
        NavigationStack{
            if profile?.volumeUnit ?? "ml" == "ml"{
                HStack{
                    Button(action: {
                        profile?.consumedWater.append(Water(date: ConvertFuncs.shortDate(), consumed: 100, unit: "ml"))
                        ViewModel.totalConsumedWaterML(array: profile?.consumedWater ?? [])
                        profile?.consumedWaterInt = ViewModel.totalConsumedML
                    }, label: {
                        Image("100ml")
                    })
                    Button(action: {
                        profile?.consumedWater.append(Water(date: ConvertFuncs.shortDate(), consumed: 200, unit: "ml"))
                        ViewModel.totalConsumedWaterML(array: profile?.consumedWater ?? [])
                        profile?.consumedWaterInt = ViewModel.totalConsumedML
                    }, label: {
                        Image("200ml")
                    })
                    Button(action: {
                        profile?.consumedWater.append(Water(date: ConvertFuncs.shortDate(), consumed: 500, unit: "ml"))
                        ViewModel.totalConsumedWaterML(array: profile?.consumedWater ?? [])
                        profile?.consumedWaterInt = ViewModel.totalConsumedML
                    }, label: {
                        Image("500ml")
                    })
                }
            } else {
                HStack{
                    Button(action: {
                        profile?.consumedWater.append(Water(date: ConvertFuncs.shortDate(), consumed: 8, unit: "floz"))
                        ViewModel.totalConsumedWaterFloz(array: profile?.consumedWater ?? [])
                        profile?.consumedWaterInt = ViewModel.totalConsumedFloz
                    }, label: {
                        Image("8floz")
                    })
                    Button(action: {
                        profile?.consumedWater.append(Water(date: ConvertFuncs.shortDate(), consumed: 12, unit: "floz"))
                        ViewModel.totalConsumedWaterFloz(array: profile?.consumedWater ?? [])
                        profile?.consumedWaterInt = ViewModel.totalConsumedFloz
                    }, label: {
                        Image("12floz")
                    })
                    Button(action: {
                        profile?.consumedWater.append(Water(date: ConvertFuncs.shortDate(), consumed: 16.9, unit: "floz"))
                        ViewModel.totalConsumedWaterFloz(array: profile?.consumedWater ?? [])
                        profile?.consumedWaterInt = ViewModel.totalConsumedFloz
                    }, label: {
                        Image("169floz")
                    })
                }
            }
            HStack{
                TextField("Other ", text: $ViewModel.other).padding(6).multilineTextAlignment(.center).border(.gray).background(RoundedRectangle(cornerRadius: 10).stroke(.gray)).cornerRadius(10).padding(.leading, 20).keyboardType(.decimalPad).onTapGesture {
                    
                }
                Button(action: {
                    ViewModel.other = ConvertFuncs.commaToDotConverter(text: ViewModel.other)
                    profile?.consumedWater.append(Water(date: Date.now.description, consumed: Double(ViewModel.other) ?? 0, unit: profile?.volumeUnit ?? "ml"))
                    ViewModel.other = ""
                    if profile?.volumeUnit ?? "ml" == "ml"{
                        ViewModel.totalConsumedWaterML(array: profile?.consumedWater ?? [])
                        
                    } else {
                        ViewModel.totalConsumedWaterFloz(array: profile?.consumedWater ?? [])
                        
                    }
                    
                }, label: {
                    Image(systemName: "plus.circle.fill").resizable().frame(width: 30, height: 30).padding(.trailing, 20)
                })
            }
            VStack{
                LargeButtonView(title: "Delete Last Added", action: {
                    ViewModel.isAlert = false
                    if profile?.consumedWater.count ?? 0 > 0 {
                        profile?.consumedWater.removeLast()
                        if profile?.volumeUnit ?? "ml" == "ml" {
                            ViewModel.totalConsumedWaterML(array: profile?.consumedWater ?? [])
                        } else {
                            ViewModel.totalConsumedWaterFloz(array: profile?.consumedWater ?? [])
                        }
                        
                        do{
                            try context.save()
                        } catch {
                            ViewModel.errMsg = error.localizedDescription
                            ViewModel.isAlert = true
                        }
                    }
                    
                }, color: .red).padding(.horizontal, 20).padding(.vertical, 20)
            }.alert("Error", isPresented: $ViewModel.isAlert) {
                Button("OK") { }
            } message: {
                Text(ViewModel.errMsg)
            }
            VStack{
                Divider()
                if profile?.volumeUnit ?? "ml" == "ml"{
                    ProgressBarComplate(color: .blue, percent: Double(100 * ViewModel.totalConsumedML / (profile?.waterGoal ?? 0)) * 0.01, kind: "Water", dailyIntake: ViewModel.totalConsumedML, dailyTarget: profile?.waterGoal ?? 0, unit: profile?.volumeUnit ?? "ml", progressImage: Image("Water"))
                } else {
                    ProgressBarComplate(color: .blue, percent: Double(100 * ViewModel.totalConsumedFloz / (profile?.waterGoal ?? 0)) * 0.01, kind: "Water", dailyIntake: ViewModel.totalConsumedFloz, dailyTarget: profile?.waterGoal ?? 0, unit: profile?.volumeUnit ?? "fl oz (US)", progressImage: Image("Water"))
                }
                
                
                Divider()
                HStack{
                    Text("Your Target").padding(0)
                    Spacer()
                    TextField("", text: $ViewModel.waterGoal)
                        .padding(6)
                        .frame(width: 100)
                        .multilineTextAlignment(.center)
                        .border(.gray)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        .cornerRadius(10)
                        .keyboardType(.decimalPad)
                    Text(profile?.volumeUnit ?? "ml").padding(0)
                    Button(action: {
                        if profile?.volumeUnit ?? "ml" == "ml"{
                            ViewModel.totalConsumedWaterML(array: profile?.consumedWater ?? [])
                        } else {
                            ViewModel.totalConsumedWaterFloz(array: profile?.consumedWater ?? [])
                        }
                        
                        
                        guard let profile = profile else {return}
                        
                        ViewModel.waterGoal = ConvertFuncs.commaToDotConverter(text: ViewModel.waterGoal)
                        profile.waterGoal = Double(ViewModel.waterGoal)
                        do{
                            try context.save()
                        } catch{
                            print("kaydedilirken hata oluştu WaterView 127. Satır")
                        }
                        
                    }) {
                        Text("Update")
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .frame(width: 100)
                    }.buttonStyle(PlainButtonStyle())
                    
                }.padding(.horizontal)
                Divider()
                VStack{
                    HStack {
                        Text("Amount of water consumed").foregroundStyle(.grayMode)
                        Spacer()
                        if profile?.volumeUnit ?? "ml" == "ml" {
                            Text("\(String(format: "%.2f", ViewModel.totalConsumedML)) \(profile?.volumeUnit ?? "ml")").foregroundStyle(.grayMode)
                        } else {
                            Text("\(String(format: "%.2f", ViewModel.totalConsumedFloz)) \(profile?.volumeUnit ?? "ml")").foregroundStyle(.grayMode)
                        }
                        
                    }
                    HStack{
                        Text("Reach your goal").foregroundStyle(.grayMode)
                        
                        Spacer()
                        if profile?.volumeUnit ?? "ml" == "ml"{
                            if (Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedML) < 0 {
                                Text("0").foregroundStyle(.grayMode)
                            } else {
                                Text("\(String(format: "%.2f", (Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedML))) \(profile?.volumeUnit ?? "ml")").foregroundStyle(.grayMode)
                            }
                        } else {
                            if (Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedFloz) < 0 {
                                Text("0").foregroundStyle(.grayMode)
                            } else {
                                Text("\(String(format: "%.2f", (Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedFloz))) \(profile?.volumeUnit ?? "ml")").foregroundStyle(.grayMode)
                            }
                        }
                        
                        
                    }
                    HStack{
                        
                        if profile?.volumeUnit ?? "ml" == "ml" {
                            if (Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedML) < 0 {
                                Text("You reached your goal").foregroundStyle(.grayMode)
                                Spacer()
                                Image(systemName: "plus.circle.fill").foregroundStyle(.blue).padding(0)
                                Text("\(String(format: "%.2f", -((Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedML)))) \(profile?.volumeUnit ?? "ml")").padding(5).background(.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundStyle(.white)
                            }
                        } else {
                            if (Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedFloz) < 0 {
                                Text("You reached your goal").foregroundStyle(.grayMode)
                                Spacer()
                                Image(systemName: "plus.circle.fill").foregroundStyle(.blue).padding(0)
                                Text("\(String(format: "%.2f", -((Double(ViewModel.waterGoal) ?? 2000) - (ViewModel.totalConsumedFloz)))) \(profile?.volumeUnit ?? "ml")").padding(5).background(.blue).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundStyle(.white)
                            }
                        }
                        
                    }
                }.padding().padding(.horizontal).padding(.bottom)
                
        }

        }.toolbar{
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
        }.onAppear{
            ViewModel.waterGoal = String(profile?.waterGoal ?? 0)
            ViewModel.totalConsumedWaterML(array: profile?.consumedWater ?? [])
            ViewModel.totalConsumedWaterFloz(array: profile?.consumedWater ?? [])
            // ----- su listesini sıfırlama
                        
            let target = ConvertFuncs.shortDate()
            profile?.consumedWater.removeAll { data in
                !data.date.contains(target)
                            }

            //        -------
        }
    }
}

#Preview {
    WaterView(userid: "123")
}
