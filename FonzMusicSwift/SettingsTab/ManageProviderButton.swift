//
//  ManageSpotifyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct ManageProviderButton: View {
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    var providerInfo : Provider
    
    @State var isExpanded = false
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        VStack{
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }, label: {
                HStack {
                    HStack(spacing: 5) {
                        if providerInfo.sessionId != nil {
                            Image("spotifyIcon").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        }
                        else {
                            Image("spotifyIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        }
                        
                            
                        Text(providerInfo.displayName)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzButtonText()
                            .padding(.horizontal)
                    }
                    Spacer()
                }.frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings, height: 20)
                .padding()
                
            })
                .buttonStyle(BasicFonzButton(bgColor: providerInfo.sessionId == nil ? .gray: Color.amber, secondaryColor: .amber))
            if isExpanded {
                VStack{
                    // make active
                if providerInfo.sessionId == nil {
                    Text("do you want to make this provider active?")
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
                            let sessionId = userAttributes.getUserSessionId()
            //                let sessionId = UserDefaults.standard.string(forKey: "userAccountSessionId")
                            // adding spot to the session
                            let updateActiveProvider = SessionApi().updateSessionProvider(sessionId: userAttributes.getUserSessionId(), providerId: providerInfo.providerId)
//                            let connectSpotifyReturn = SpotifySignInFunctions().addSpotifyToCurrentSession(sessionId: sessionId)
                            withAnimation {
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
                    // coaster bane
                    Text("do you want to disconnect this provider?")
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
                    // coaster bane
                   
                        
                        
                    
                }
                .frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings)
    
            }
        }
        
    }
    
}
