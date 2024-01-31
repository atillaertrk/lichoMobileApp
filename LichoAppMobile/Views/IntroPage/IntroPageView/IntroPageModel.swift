//
//  IntroPageModel.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import Foundation

struct IntroPageModel : Identifiable, Equatable {
    var id = UUID()
    var name : String
    var title : String
    var descriptions : String
    var image : String
    var tag : Int
    
    static var samplePage = IntroPageModel(name: "sample", title: "Sample Title", descriptions: "lorem ipsum sit dolor vs lorem ipsum sit dolor vs lorem ipsum sit dolor vs lorem ipsum sit dolor vs and lorem ipsum sit dolar ttc ", image: "setImage", tag: 0)
    
    static var pages :[IntroPageModel] = [
    IntroPageModel(name: "first", title: "congratulations", descriptions: "If you installed this application, it means you want to take control of your life. We need some information for this.", image: "intro", tag: 0),
    IntroPageModel(name: "second", title: "information Security", descriptions: "Your information is kept completely confidential. It is not shared with any institution or person. We need this information to make calculations such as ideal weight and daily calorie needs.", image: "safeData", tag: 1),
    IntroPageModel(name: "third", title: "let's start", descriptions: "", image: "calculateImg", tag: 2)
    ]
}
