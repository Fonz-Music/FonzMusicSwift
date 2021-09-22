//
//  HostAPartyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct SetupACoasterButton: View {

    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    @Binding var showHomeButtons: Bool
    
    @Binding var pressedButtonToLaunchNfc: Bool
    
    // has user create an account
//    @State var throwCreateAccountModal = false
    
    // has user download the full app
    @State var throwDownloadFullAppModal = false
 
    // has user create an account
    @State var throwCreateAccountModal = false
    // gives user option to connect their spotify
    @State var throwConnectSpotifyPrompt = false
    
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.04
    
    var body: some View {
        VStack{
            Button(action: {
                // if they're using full app
                #if !APPCLIP
                // if they have spot
                if userAttributes.getConnectedToSpotify() {
                
                    if userAttributes.getHasAccount() {
                        withAnimation {
                            pressedButtonToLaunchNfc = true
                            showHomeButtons = false
                        }
                        FirebaseAnalytics.Analytics.logEvent("userTappedSetupCoaster", parameters: ["user":"user", "tab":"search"])

                    }
                    else {
                        throwCreateAccountModal = true
                    }
                
                }
                // if no spot
                else {
                    // ask if they wanna launch spotify
                    throwConnectSpotifyPrompt = true
                }
                
                #else
                throwDownloadFullAppModal = true
                #endif
                
            }, label: {
                Image("coasterIconLilac").resizable().frame(width: sideGraphicHeight * 1.1, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 75, height: 75)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilacDark))
//            Text("i want to setup my coaster")
//                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
//                .fonzRoundButtonText()
            Text("setup coaster")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
        }
        .sheet(isPresented: $throwCreateAccountModal) {
            CreateAccountPrompt(userAttributes: userAttributes, showModal: $throwCreateAccountModal)
        }
        .sheet(isPresented: $throwDownloadFullAppModal, content: {
            DownloadFullAppPrompt()
        })
        .sheet(isPresented: $throwConnectSpotifyPrompt, onDismiss: {
            // if they dont add spot
            if !userAttributes.getConnectedToSpotify() {
            }
            // if they do have spot
            else {
                withAnimation {
                    pressedButtonToLaunchNfc = true
                    showHomeButtons = false
                }
                
            }
            
        }) {
            AskUserToConnectSpotify(showModal: $throwConnectSpotifyPrompt)
        }
        
        
    }
    
}
