//
//  IntroPageView.swift
//  Licho
//
//  Created by Atilla Ertürk on 25.01.2024.
//

import SwiftUI
import SwiftData

struct IntroPageView: View {

    @State private var pageIndex = 0
    @EnvironmentObject var AuthModel : AuthModel
    public init(userid: String) {
        self._userid = State(initialValue: userid)
    }
    @State var userid : String
    private let pages : [IntroPageModel] = IntroPageModel.pages
    private var dotAppearrence = UIPageControl.appearance()
    var body: some View {
        Text("user id = \(userid)")
 
        TabView(selection: $pageIndex){
            ForEach(pages) { page in
                VStack{
                    
                    PageView(page: page)
                    if page == pages.last {
                        SetInfoView(userId: self.userid)
                    } else {
                        Button("Next") {
                            incrametIndex()
                        }.padding(.top).buttonStyle(.borderedProminent)
                    }
                }.tag(page.tag).ignoresSafeArea(.keyboard, edges: .bottom)
                
            }
            
        }.animation(.easeOut, value: pageIndex)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onChange(of: pageIndex){
                
                if pageIndex == 2 {
                    
                    self.dotAppearrence.isHidden = true
                    
                    
                }
            }
            .onAppear{
                dotAppearrence.isHidden = true

                
                Task{
                    do{
                        
                        
                        print("onappear task intropage")
                    }
                }
                
                
                
            }

    }
    func incrametIndex(){
        if pageIndex < 2 {
            pageIndex += 1
        }
    }
}

#Preview {
    IntroPageView(userid: "123").environmentObject(AuthModel())
}
