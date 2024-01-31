//
//  SettingsViewVM.swift
//  Licho
//
//  Created by Atilla Ertürk on 30.01.2024.
//

import Foundation

class SettingsViewVM : ObservableObject {
    @Published var username : String = ""
    @Published var showEmail : Bool = false
    @Published var isProgress : Bool = false
}
