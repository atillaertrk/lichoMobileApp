//
//  SetInfoView.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import SwiftUI
import SwiftData

struct SetInfoView: View {
    @EnvironmentObject var AuthModel : AuthModel
    @StateObject var ViewModel = SetInfoViewVM()
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]
    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userId }
    }
    var userId : String
    
    var body: some View {
//        List {
//        ForEach(mySwiftData){ i in
//
//                VStack{
//                    Text(i.userId ?? "")
//                    Text(i.userName ?? "")
//                    Text(i.email ?? "")
//                }.task {
//                    print(mySwiftData.count)
//                }
//        }
//        .onDelete(perform: { indexSet in
//                indexSet .forEach { index in
//                    let data = mySwiftData[index]
//                    context.delete(data)
//                    do{
//                        try context.save()
//                    } catch{
//
//                    }
//                }
//            })
//
//        }
        VStack{
            VStack{
                Text("TEST SCREEN").foregroundStyle(.red)
                Text(profile?.email ?? "profile email")
                Text(profile?.userId ?? "profile id")
                Text(profile?.userName ?? "username")
                HStack{
                    Text(String(profile?.height ?? 0))
                    Text(String(profile?.weight ?? 0))
                    Text(String(profile?.age ?? 0))
                }
                
            }.padding().border(Color.red)
            HStack{
                TextField("Height", text: $ViewModel.height).padding(.vertical, 4).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                Picker("Height Unit", selection: $ViewModel.selectedHeightUnit) {
                    ForEach(ViewModel.heightUnits, id: \.self) { unit in
                        Text(unit)
                    }
                }
            }.padding(.horizontal)
            HStack{
                
                TextField("Weight", text: $ViewModel.weight).padding(.vertical, 4).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                Picker("Weight Unit", selection: $ViewModel.selectedWeightUnit) {
                    ForEach(ViewModel.weightUnits, id: \.self) { unit in
                        Text(unit)
                    }
                }
            }.padding(.horizontal)
            HStack{
                
                TextField("Age", text: $ViewModel.age).padding(.vertical, 4).padding(.horizontal).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1)).frame(width: 70)
                Spacer()
                Text("Gender").foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.255))
                Picker("Gender", selection: $ViewModel.selectedGender) {
                    ForEach(ViewModel.genders, id: \.self) { unit in
                        Text(unit)
                        
                    }
                }
            }.padding(.horizontal)
            Divider()
            HStack {
                
                Text("Daily Activity").foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.255))
                Spacer()
                Picker("", selection: $ViewModel.selectedActivty){
                    ForEach(ViewModel.activityLevel, id: \.self){ unit in
                        Text(unit)
                        
                    }
                }
                
            }.padding(.horizontal)
            
//            READY BUTTON
            
            LargeButtonView(title: "I'm Ready", action: {
//                UserDefaults.standard.set(false, for: "isFirstLogin")
                UserDefaults.standard.isFirstLogin.toggle()
                
                
                profile?.height = Double(ViewModel.height)
                profile?.weight = Double(ViewModel.weight)
                profile?.age = Int(ViewModel.age)
                profile?.gender = ViewModel.selectedGender
                profile?.activity = ConvertFuncs.activityToInt(selectedActivity: ViewModel.selectedActivty)
                do{
                    try context.save()
                } catch {
                    print("HATA SetInfoReadyButton")
                    print(error.localizedDescription)
                }
            }, color: .greenLogo)
        }.frame(alignment: .center).padding(.horizontal, 20)
        }
}

#Preview {
    SetInfoView(userId: "123").environmentObject(AuthModel()).modelContainer(for : UserInfoSwiftDataModel.self)
}
