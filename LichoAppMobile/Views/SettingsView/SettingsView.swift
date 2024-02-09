//
//  SettingsView.swift
//  Licho
//
//  Created by Atilla Ertürk on 30.01.2024.
//

import SwiftUI
import SwiftData
import Firebase

struct SettingsView: View {
    var userid : String
    @StateObject var ViewModel = SettingsViewVM()
    @Environment (\.modelContext) private var context
    @Query (sort: \UserInfoSwiftDataModel.height, order: .forward) private var mySwiftData : [UserInfoSwiftDataModel]
    var profile: UserInfoSwiftDataModel? {
        return mySwiftData.first { $0.userId == userid }
    }
    var body: some View {
        NavigationStack {
            VStack{
                HeaderView()
                List{
                    Section{
                        
                        VStack{
                            Divider()
                            HStack{
                                Text("Username").foregroundStyle(.softBlack)
                                Spacer()
                                TextField("username", text: $ViewModel.username).padding(5).foregroundStyle(.softBlack).frame(width: 200, alignment: .leading).border(Color.black.opacity(0.1)).onAppear{
                                    Task{
                                        do{
                                            ViewModel.username = profile?.userName ?? ""
                                        }
                                    }
                                }
                                
                            }
                            HStack{
                                Text("Email").foregroundStyle(.softBlack)
                                Spacer()
                                Text(profile?.email ?? "admin_erturk_1232@admmin.com").lineLimit(1).padding(5).foregroundStyle(.gray).frame(width: 200, alignment: .leading).border(Color.black.opacity(0.1))
                                
                            }.onTapGesture {
                                if profile?.userName?.count ?? 0 > 19 {
                                    withAnimation {
                                        ViewModel.showEmail.toggle()
                                    }
                                }
                                
                            }
                            if ViewModel.showEmail {
                                Text(profile?.userName ?? "").padding(.top, 0).opacity(ViewModel.showEmail ? 1 : 0)
                            }
                            ZStack{
                                if ViewModel.isProgress {
                                    ProgressView().zIndex(1).tint(Color.white).controlSize(.large)
                                }
                                Button("Change & Save Username", image: ImageResource(name: "saveIcon", bundle: .main)) {
                                    
                                    ViewModel.isProgress = true
                                    Task{
                                        do {
                                            profile?.userName = ViewModel.username
                                            try context.save()
                                           
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                                ViewModel.isProgress = false
                                               
                                            }
                                        } catch {
                                            ViewModel.isProgress = false
                                        }
                                    }
                                    
                                }.buttonStyle(.bordered).foregroundStyle(.softBlack).disabled(ViewModel.isProgress)
                                
                            }
                            
                        }
                        
                        
                    } header: {
                        HStack{
                            Image(systemName: "person.fill").font(.callout).foregroundStyle(.addButton)
                            Text("Username").foregroundStyle(.addButton).font(.callout)
                        }
                    }
                    Section{
//                    not eklenecek
                    } header: {
                        HStack{
                            Image(systemName: "bell.fill").font(.callout).foregroundStyle(.addButton)
                            Text("Notifications").foregroundStyle(.addButton).font(.callout)
                        }
                    }
                    Section{
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
                                    Text("Logout").foregroundStyle(.softBlack)
                                    Spacer()
                                    Image(systemName: "arrowshape.right.circle").font(.title2)
                                }
                                
                                
                            }).buttonStyle(BorderedButtonStyle()).background(.ultraThinMaterial)
                            
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
                            }.buttonStyle(BorderedButtonStyle()).background(.ultraThinMaterial).padding(.top, 1)
                            
                        }
                    } header: {
                        HStack{
                            Image(systemName: "person.text.rectangle").font(.callout).foregroundStyle(.addButton)
                            Text("Account").foregroundStyle(.addButton).font(.callout)
                        }
                    }

                    
                }.scrollContentBackground(.hidden)
            }.navigationBarTitleDisplayMode(.inline)
        }.toolbar{
            ToolbarItem {
                Image(systemName: "gearshape").foregroundStyle(.linearGradient(colors: [Color.softBlack, Color.white], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
    }
}

#Preview {
    SettingsView(userid: "123")
}
