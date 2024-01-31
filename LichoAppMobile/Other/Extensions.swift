//
//  Extensions.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation
import UIKit

extension  Encodable {
    func asDictionary() -> [String:Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UserDefaults {
    @objc dynamic var isFirstLogin: Bool {
        get { bool(forKey: "isFirstLogin") }
        set { set(newValue, forKey: "isFirstLogin") } // Değerin "status" yerine "isFirstLogin" olarak atanması
    }
}
