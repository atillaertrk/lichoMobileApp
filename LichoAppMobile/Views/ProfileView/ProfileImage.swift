//
//  ProfileImage.swift
//  Licho
//
//  Created by Atilla Ertürk on 26.01.2024.
//

import SwiftUI

struct ProfileImage: View {
    let username : String
    var body: some View {
        
        HStack(alignment: .center){
            Circle().fill(.white).stroke(.black, lineWidth: 0.2).frame(width: 100, height: 100).overlay {
                
                Text("\(getFirstCharacter(from:username))\(getCharacterAfterSpace(from:username))").font(.largeTitle).foregroundStyle(.black).fontWeight(.light)
            }.frame(alignment: .center)
        }
    }
    func getFirstCharacter(from str: String) -> String {
        guard let firstCharacter = str.first else {
            return ""
        }
        return String(firstCharacter).uppercased()
    }
    
    // Eğer boşluk varsa ilk boşluktan sonraki harfi alma fonksiyonu
    func getCharacterAfterSpace(from str: String) -> String {
        let components = str.components(separatedBy: " ")
        guard components.count > 1 else {
            return ""
        }
        let secondWord = components[1]
        guard let firstCharacter = secondWord.first else {
            return ""
        }
        return String(firstCharacter).uppercased()
    }
}

#Preview {
    ProfileImage(username: "ayça demir")
}
