//
//  ProfileEditView.swift
//  Licho
//
//  Created by Atilla Ertürk on 27.01.2024.
//

import SwiftUI
import SwiftData

struct ProfileEditView: View {
    var userid : String
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]
    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }
    }

    @StateObject var ViewModel = ProfileEditViewVM()
    
    var body: some View {
        
        NavigationStack{
            
            
            ZStack{
//                Color.clear.ignoresSafeArea()
//                LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
//                    .edgesIgnoringSafeArea(.all)
//                RadialGradient(gradient: Gradient(colors: [.homeOrange, .white]), center: .center, startRadius: 2, endRadius: 650).edgesIgnoringSafeArea(.all)
                VStack{
                    HeaderView()
                    ZStack{
                        
                        if !ViewModel.active {
                            ProgressView().zIndex(1).tint(Color.white).controlSize(.large).onAppear(perform: {
                                
                            })
                        }
                        HStack{
                            if ViewModel.checkMark {
                                Image(systemName: "checkmark.circle").zIndex(2).foregroundStyle(.darkgreen).font(.largeTitle).symbolEffect(.bounce, value: ViewModel.animation)
                            } else if ViewModel.xCircle {
                                Image(systemName: "x.circle").zIndex(2).foregroundStyle(.red).font(.largeTitle).symbolEffect(.bounce, value: ViewModel.animation)
                            }
                            LargeButtonView(title: "Save Changes", action: {
                                
                                profile?.gender = ViewModel.selectedGender
                                profile?.age = Int(ViewModel.age)
                                profile?.activity = ConvertFuncs.activityToInt(selectedActivity: ViewModel.selectedActivity)
                                profile?.heightUnit = ViewModel.selectedHeightUnit
                                profile?.weightUnit = ViewModel.selectedWeightUnit
                                profile?.volumeUnit = ViewModel.selectedVolumeUnit
                                profile?.height = Double(ViewModel.userHeight)
                                profile?.weight = Double(ViewModel.userWeight)
                                profile?.waterGoal = Double(ViewModel.waterGoal)
                                Task{
                                    do {
                                        
                                        ViewModel.active = false
                       
                                        try context.save()
                                       
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                            ViewModel.animation.toggle()
                                            ViewModel.checkMark = true
                                            ViewModel.active = true
                                            ViewModel.xCircle = false
                                        }
                                    }catch{
                                        ViewModel.xCircle = true
                                        ViewModel.errMSG = "Data Failed to Save. Please again later"
                                        ViewModel.alertBool = true
                                        ViewModel.active = true
                                    }
                                    
                                }
                                
                            }, color: .addButton).disabled(!ViewModel.active)
                        }.padding(.horizontal).padding(.horizontal)
                    }
                    List{
         
                                        Section{
                                            HStack{
                                                Text("Gender")
                                                Spacer()
                                                Picker("", selection: $ViewModel.selectedGender) {
                                                    ForEach(ViewModel.genders, id: \.self){ unit in
                                                        Text(unit)
                                                        
                                                    }
                                                }
                                            }
                                            HStack{
                                                Text("Age")
                                                Spacer()
                                                TextField("", text: $ViewModel.age).textFieldStyle(.roundedBorder).frame(width: 100).keyboardType(.decimalPad)
                                            }
                                            HStack{
                                                Text("Daily Activity")
                                                Spacer()
                                                Picker("", selection: $ViewModel.selectedActivity) {
                                                    ForEach(ViewModel.activityLevel, id: \.self){
                                                        unit in
                                                        Text(unit)
                                                    }
                                                }
                                            }
                                        } header: {
                                            HStack{
                                                Image(systemName: "person.and.background.striped.horizontal").font(.callout).foregroundStyle(.addButton)
                                                Text("General").foregroundStyle(.addButton).font(.callout)
                                            }
                                            
                                        } footer: {
                                            Text("These values are used for calculations such as ideal weight and nutritional values.")
                                        }
                                        Section{
                                            HStack {
                                                Text("Height Unit")
                                                Spacer()
                                                Picker("", selection: $ViewModel.selectedHeightUnit ){
                                                    ForEach (ViewModel.heightUnits, id: \.self) { unit in
                                                        Text(unit)
                                                    }
                                                }
                                            }
                                            HStack{
                                                Text("Weight Unit")
                                                Spacer()
                                                Picker("", selection: $ViewModel.selectedWeightUnit ){
                                                    ForEach (ViewModel.weightUnits, id: \.self) { unit in
                                                        Text(unit)
                                                    }
                                                }
                                            }
                                            HStack{
                                                Text("Volume Unit")
                                                Spacer()
                                                Picker("", selection: $ViewModel.selectedVolumeUnit ){
                                                    ForEach (ViewModel.volumeUnits, id: \.self) { unit in
                                                        Text(unit)
                                                    }
                                                }
                                            }
                                            
                                        } header: {
                                            HStack{
                                                Image(systemName: "scalemass.fill").font(.callout).foregroundStyle(.addButton)
                                                Text("UNITS").foregroundStyle(.addButton).font(.callout)
                                            }
                                        }
                                        Section{
                                            HStack{
                                                Text("Height")
                                                Spacer()
                                                TextField("", text: $ViewModel.userHeight).textFieldStyle(.roundedBorder).frame(width: 100).keyboardType(.decimalPad)
                                            }
                                            HStack{
                                                Text("Weight")
                                                Spacer()
                                                TextField("", text: $ViewModel.userWeight).textFieldStyle(.roundedBorder).frame(width: 100).keyboardType(.decimalPad)
                                            }
                                            
                                        } header: {
                                            HStack{
                                                Image(systemName: "figure.cooldown").font(.callout).foregroundStyle(.addButton)
                                                Text("Body Values").foregroundStyle(.addButton).font(.callout)
                                            }
                                            
                                        } footer: {
                                            Text("These values are used for calculations such as ideal weight and nutritional values.")
                                        }
                                        Section{
                                            HStack{
                                                Text("Water Consumption")
                                                Spacer()
                                                TextField("", text: $ViewModel.waterGoal).textFieldStyle(.roundedBorder).frame(width: 100).keyboardType(.decimalPad)
                                                Text(profile?.volumeUnit ?? "ml").foregroundStyle(.gray)
                                            }
                                        } header: {
                                            HStack{
                                                Image(systemName: "target").font(.callout).foregroundStyle(.addButton)
                                                Text("GOALS").foregroundStyle(.addButton).font(.callout)
                                            }
                                            
                                        }.alert("Error", isPresented: $ViewModel.alertBool) {
                                            Button("OK") { }
                                        } message: {
                                            Text(ViewModel.errMSG)
                                        }
                    }.scrollContentBackground(.hidden).onAppear{
                        
                        
                        guard profile != nil else {
                            ViewModel.errMSG = "Failed to load user data. Please try logging in again."
                            ViewModel.alertBool = true
                            return
                        }
                        ViewModel.selectedActivity = ConvertFuncs.activityToString(selectedActivity: profile?.activity ?? 1)
                        ViewModel.selectedGender = profile?.gender ?? "Prefer not to say"
                        ViewModel.age = String(profile?.age ?? 20)
                        ViewModel.selectedWeightUnit = profile?.heightUnit ?? "cm"
                        ViewModel.selectedWeightUnit = profile?.weightUnit ?? "kg"
                        ViewModel.selectedVolumeUnit = profile?.volumeUnit ?? "ml"
                        ViewModel.userHeight = String(profile?.height ?? 0)
                        ViewModel.userWeight = String(profile?.weight ?? 0)
                        ViewModel.waterGoal = String(profile?.waterGoal ?? 0)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileEditView(userid: "123")
}
