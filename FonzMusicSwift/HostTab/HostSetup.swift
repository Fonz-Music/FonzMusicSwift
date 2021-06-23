//
//  HostSetup.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI
import Foundation
import Firebase

struct HostSetup: View {
    
    @State var darkenButton = true
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 75)
            VStack {
                Text("1. connect to spotify")
                    .foregroundColor(Color.white)
                    .fonzParagraphOne()
                    .padding(25)
                    .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                ConnectToSpotifyButton()
                    .padding()
            }
            .addOpacity(!darkenButton)
            VStack{
                Text("2. connect your first coaster")
                    .foregroundColor(Color.white)
                    .fonzParagraphOne()
                    .padding(25)
                    .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                ConnectYourFirstCoasterButton()
                    .padding()
            }
            .addOpacity(darkenButton)
            Spacer()
        }
    }
}

struct ConnectToSpotifyButton: View {
// ---------------------------------- created in view -----------------------------------------------

    @State var pressedButtonToLaunchSpotifySignIn : Bool = false
//
//    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        ZStack {
//            if (pressedButtonToLaunchSpotifySignIn) {
//                LaunchSpotifyWebview()
//                    .frame(width: 0, height: 0)
//            }
    
            Button(action: {
                withAnimation {
    //                selectedTab = 1
//                    pressedButtonToLaunchSpotifySignIn = true
                        
                   
                }
                guard let user = Auth.auth().currentUser else {
                    print("there was an error getting the user")
                    return
                }
                user.getIDToken(){ (idToken, error) in
                if error == nil, let token = idToken {
                    let userToken = token
                    
                    guard let url = URL(string: "https://api.fonzmusic.com/auth/spotify?token=\(userToken)") else {
                        return
                    }
                    openURL(url)
                }
                }
                
//                print(userToken)
                
                
                
                
            }, label: {
                Image("spotifyIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .successGreen))
        }
    }
}

struct ConnectYourFirstCoasterButton: View {
// ---------------------------------- created in view -----------------------------------------------

//    @Binding var pressedButtonToLaunchNfc : Bool
//
//    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        Button(action: {
            withAnimation {
//                selectedTab = 1
            }
            
        }, label: {
            Image("coasterIcon").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .frame(width: 125, height: 125)
        })
        .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: colorScheme == .light ? Color.darkButton:Color.white))
        
    }
}

