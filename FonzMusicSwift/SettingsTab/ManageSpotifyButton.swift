//
//  ManageSpotifyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct ManageSpotifyButton: View {
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    @State var isExpanded = false
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        VStack{
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
                print("pressed button")
                
            }, label: {
                HStack {
                    HStack(spacing: 5) {
                        Image("spotifyIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                            
                        Text(userAttributes.getSpotifyDisplayName())
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzButtonText()
                            .padding(.horizontal)
                    }
                    Spacer()
                }.frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings, height: 20)
                .padding()
                
            })
            .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
            if isExpanded {
                VStack{
                    // coaster bane
                    Text("do you want to disconnect Spotify?")
                        .padding(.horizontal, 10)
                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .multilineTextAlignment(.center)
                        .fonzParagraphTwo()
                    HStack{
                        Spacer()
                        Button {
                           
                            withAnimation {
                                isExpanded = false
                            }
                            
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .frame(width: 20 , height: 20, alignment: .center)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                            
            //                    .padding()
                        }
                        .frame(width: 80, height: 40, alignment: .center)
                        .buttonStyle(BasicFonzButton(bgColor: .amber, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                        .padding(.vertical, 5)
                        Spacer()
                        Button {
                            FirebaseAnalytics.Analytics.logEvent("userPressedManageSpotify", parameters: ["user":"user", "tab": "settings"])
                //                    pressedButtonToLaunchNfc = true
                            print("pressed button")
                            
                            UserDefaults.standard.set(false, forKey: "connectedToSpotify")
                            withAnimation {
                                userAttributes.setConnectedToSpotify(bool: false)
                                isExpanded = false
                            }
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .frame(width: 20 , height: 20, alignment: .center)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                        }
                        .frame(width: 80, height: 40, alignment: .center)
                        .buttonStyle(BasicFonzButton(bgColor: .amber, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                        .padding(.vertical, 5)
                        Spacer()
                    }
                }
                .frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings)
    
            }
        }
        
    }
}
