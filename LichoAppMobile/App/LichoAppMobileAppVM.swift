//
//  LichoAppMobileAppVM.swift
//  LichoAppMobile
//
//  Created by Atilla Ertürk on 30.01.2024.
//

import Foundation
import Firebase
import Combine

class LichoAppMobileAppVM : ObservableObject {
    static let shared = LichoAppMobileApp()
    @Published var userId : String = ""
    @Published var isFirstLogin: Bool {
        didSet {
            UserDefaults.standard.isFirstLogin = isFirstLogin
        }
    }
    private var cancellables = Set<AnyCancellable>() // Set'i tanımla

    init(){
        isFirstLogin = UserDefaults.standard.isFirstLogin // Anahtarın başlangıç değerini atama

                
                let publisher = UserDefaults.standard.publisher(for: \.isFirstLogin)
            
                    .removeDuplicates() // Tekrar eden değerleri kaldırma
                    .receive(on: DispatchQueue.main) // Ana kuyruğa geçiş yapma
                
                cancellables.insert(
                    publisher
                        .assign(to: \.isFirstLogin, on: self) // Anahtardaki değişiklikleri izleme ve değişiklikleri yayma
                )

        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.userId = user?.uid ?? ""
            }
        }

        
print(isFirstLogin)
    }
}
