//
//  CreateAccountHomeButton.swift
//  FonzMusicSwift
//
//  Created by didi on 8/9/21.
//

import SwiftUI
import Foundation
//import Firebase
import FirebaseAnalytics


struct CreateAccountHomeButton: View {
    
// ------------------------------ inherited from parent ------------------------------------------

    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
// ---------------------------------- created in view --------------------------------------------
    // has user download full app if on app clip
    @State var throwDownlaodFullAppModal = false

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    let sideGraphicHeight = UIScreen.screenHeight * 0.03
    
    var body: some View {
        VStack {
            Button(action: {
                userAttributes.showSignUpModal = true
            }, label: {
                Image(systemName: "person.crop.circle.badge.plus")
                    
                    .resizable()
                    .foregroundColor(.spotifyGreen)
                    .frame(width: sideGraphicHeight * 1.1, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .frame(width: 75, height: 75)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .spotifyGreen))
            Text("create an account")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
//                .fonzRoundButtonText()
                .fonzParagraphTwo()
        }
//        .sheet(isPresented: $throwCreateAccountModal) {
//            CreateAccountPrompt(userAttributes: userAttributes, showModal: $throwCreateAccountModal)
//        }
//        .sheet(isPresented: $throwDownlaodFullAppModal) {
//            DownloadFullAppPrompt()
//        }
    }
}
