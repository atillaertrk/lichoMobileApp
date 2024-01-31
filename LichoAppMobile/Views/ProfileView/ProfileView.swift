//
//  ProfileView.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI
import Firebase
import SwiftData

struct ProfileView: View {
    var userid : String
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]
    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }
    }
    var body: some View {
        
        NavigationStack{
            ZStack{
                
//                Color(red: 0.584, green: 0.819, blue: 0.949).opacity(1).ignoresSafeArea(.all)
               
                VStack {
                    HStack{
                        
                        VStack(alignment: .center) {
                            ProfileImage(username: profile?.userName ?? "Atilla")
                            Text(profile?.userName?.capitalized ?? "admin").foregroundStyle(.grayMode)
                        }
                        
                        InfoCardView(height: profile?.height ?? 0, weight: profile?.weight ?? 0, BMR: UserMeasurementsCalc.calculateBMR(height: profile?.height ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg", weight: profile?.weight ?? 0, age: profile?.age ?? 0, gender: profile?.gender ?? "Prefer not to say"), BMI: UserMeasurementsCalc.calculateBmi(height: profile?.height ?? 0, weight: profile?.weight ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg"), idealWeight: UserMeasurementsCalc.idealWeight(height: profile?.height ?? 0, weightUnit: profile?.weightUnit ?? "kg", heightUnit: profile?.heightUnit ?? "cm", gender: profile?.gender ?? "Prefer not to say"), heightUnit: profile?.heightUnit ?? "cm", weiightUnit: profile?.weightUnit ?? "kg")
                        Spacer()
                        
                    }.padding(.top, 5).padding(.horizontal)
                    Divider()
                        NavigationLink {
                            ProfileEditView(userid: userid)
                        } label: {
                            HStack{
                                Text("Edit height, weight and goals").foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "greaterthan.circle").foregroundStyle(.blue)
                                
                            }.padding().padding(.horizontal)
                        }

                    Divider()
                    List {
                        
                        Section("BMI (Body Mass Index)"){
                            if  UserMeasurementsCalc.calculateBmi(height: profile?.height ?? 0, weight: profile?.weight ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg") > 0 {
                                BMIbarView(percent: (UserMeasurementsCalc.calculateBmi(height: profile?.height ?? 0, weight: profile?.weight ?? 0, heightUnit: profile?.heightUnit ?? "cm", weightUnit: profile?.weightUnit ?? "kg") * 2.5 / 100) - 0.03).padding(.bottom)
                            } else {
                                BMIbarView(percent: -0.03).padding(.bottom)
                            }
                            Text("BMI is a measurement that assesses the relationship between weight and height. It is used to understand overall weight status, although it may not fully reflect individual health conditions.").font(.callout).fontWeight(.light).padding(.vertical)
                           
                        }
                        

                        Section("LOGOUT"){
                            VStack(alignment: .leading){
                                Button(action: {
                                    DispatchQueue.main.async {
                                        do{
                                            try Auth.auth().signOut()
                                        }
                                        catch {
                                            print("HATA Test View")
                                            print(error.localizedDescription)
                                        }
                                    }
                                }, label: {
                                    HStack{
                                        Text("Logout").foregroundStyle(.black)
                                        Spacer()
                                        Image(systemName: "arrowshape.right.circle").font(.title2)
                                    }
                                    
                                    
                                })
                                
                            }
                        }
                        Section("Delete Account"){
                            Button {
                                Auth.auth().currentUser?.delete(completion: { error in
                                    if let error = error {
                                        print("Hesap silme hatası: \(error.localizedDescription)")
                                    } else {
                                        
                                        let db = Firestore.firestore()
                                        
                                        
                                        db.collection("users").document(userid).delete { error in
                                            if let error = error {
                                                print("Firestore veri silme hatası: \(error.localizedDescription)")
                                            } else {
                                                UserDefaults.standard.set(false, forKey: "isFirstLogin")
                                                print("Firestore'dan veriler başarıyla silindi.")
                                                print("hesap silindi")
                                            }
                                        }
                                    }
                                    
                                })
                            } label: {
                                HStack{
                                    Text("Delete Account").foregroundStyle(.pink)
                                    Spacer()
                                    Image(systemName: "trash.circle").foregroundStyle(.pink).font(.title2)
                                }
                            }.padding(.top)
                        }
                                            }.scrollContentBackground(.hidden).toolbar(content: {
                        ToolbarItem {
                            NavigationLink {
                                SettingsView(userid: userid)
                            } label: {
                                Image(systemName: "gearshape")
                            }
                            
                        }
                        
                    }).toolbarBackground(.visible, for: .navigationBar)
                    

                    
                    
                    
                    //                            List{
                    //                                Section("BMI"){
                    //                                    VStack{
                    //                                        BMIbarView(percent: 0.6)
                    //
                    //                                    }
                    //
                    //                                }
                    //
                    //
                    //                            }
                }
                    
            }
            
        }.navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    ProfileView(userid: "123")
}
