//
//  GetFullAppButton.swift
//  FonzMusicSwift
//
//  Created by didi on 8/9/21.
//

import SwiftUI

struct GetFullAppButton: View {
    // ------------------------------ inherited from parent ------------------------------------------

        // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
        @StateObject var userAttributes : CoreUserAttributes
    // ---------------------------------- created in view --------------------------------------------
        // has user download full app if on app clip
        @State var throwDownlaodFullAppModal = false

        @Environment(\.colorScheme) var colorScheme
        @Environment(\.openURL) var openURL
        let sideGraphicHeight = UIScreen.screenHeight * 0.045
        
        var body: some View {
            VStack {
                Button(action: {
                    guard let url = URL(string: "https://apps.apple.com/us/app/fonz-music/id1537308329") else {
                        return
                    }
                    openURL(url)
                }, label: {
                    Image("fonzLogoF")
                        .resizable()
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .frame(width: sideGraphicHeight * 0.45, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .frame(width: 75, height: 75)
                })
                .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: colorScheme == .light ? Color.darkButton: Color.white))
                Text("get the full app")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
    //                .fonzRoundButtonText()
                    .fonzParagraphTwo()
            }
    //        .sheet(isPresented: $throwCreateAccountModal) {
    //            CreateAccountPrompt(userAttributes: userAttributes, showModal: $throwCreateAccountModal)
    //        }
            .sheet(isPresented: $throwDownlaodFullAppModal) {
                DownloadFullAppPrompt()
            }
        }
    }
