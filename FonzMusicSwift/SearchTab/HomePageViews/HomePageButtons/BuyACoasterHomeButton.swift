//
//  BuyACoasterHomeButton.swift
//  FonzMusicSwift
//
//  Created by didi on 7/17/21.
//

import SwiftUI
import FirebaseAnalytics

struct BuyACoasterHomeButton: View {
    
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.03
    
    @State var launchWebview = false
    
    var body: some View {
        VStack{
            Button(action: {
                
//                getUserIdFromAccessToken()
                
                guard let url = URL(string: "https://www.fonzmusic.com/buy") else {
                    return
                }
                openURL(url)
                print("pressed button")

//                launchWebview.toggle()
                FirebaseAnalytics.Analytics.logEvent("userPressedBuyCoaster", parameters: ["user":"user", "tab": "search"])
                
            }, label: {
                Image(systemName: "cart.badge.plus")
                    
                    .resizable()
                    .foregroundColor(.lilacDark)
                    .frame(width: sideGraphicHeight * 1.1, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .frame(width: 75, height: 75)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilacDark))
            Text("buy a coaster")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
//            if launchWebview {
//                ShopWebView()
//                    .frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            }
        }
    }
}
