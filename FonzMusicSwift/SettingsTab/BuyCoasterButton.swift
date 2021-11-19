//
//  BuyCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
import Foundation
import KeychainAccess
import FirebaseAnalytics

struct BuyCoasterButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
    @State var offset = 0
    
    @State var launchShopModal : Bool = false
    
    var body: some View {
        Button(action: {
            
//            let sessionId = "60224ecc-a00f-437a-8743-4909a8eb7a6c"
//            SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: sessionId, offset: offset)
//            offset += 10

//            guard let url = URL(string: "https://www.fonzmusic.com/buy") else {
//                return
//            }
//            openURL(url)
//            print("pressed button")
            launchShopModal = true
            FirebaseAnalytics.Analytics.logEvent("userPressedBuyCoaster", parameters: ["user":"user", "tab": "settings"])
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image("coasterIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        
                    Text("buy a coaster")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal)                        }
                Spacer()
            }.frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings, height: 20)
            .padding()
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        .sheet(isPresented: $launchShopModal) {
            ShopPage(launchShopModal: $launchShopModal)
        }
//        .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
    }
        
}
