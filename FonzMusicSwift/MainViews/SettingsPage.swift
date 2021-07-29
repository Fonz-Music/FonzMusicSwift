//
//  SettingsPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/14/21.
//

import SwiftUI
import KeychainAccess

struct SettingsPage: View {
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // bool on if the user has coasters connected
    @Binding var hasConnectedCoasters : Bool
    // bool to launch create account modal
    // determines if current user is connected to Spotify
    @Binding var connectedToSpotify : Bool
    
    @State var throwCreateAccountModal = false
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            VStack{
                if hasAccount {
                    HStack{
                        Text("account")
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                            .padding(.headingFrontIndent)
                            .padding(.top, .headingTopIndent)
                            .addOpacity(!hasAccount)
        //                        .padding(.bottom, 20)
                        Spacer()
                    }
                    // if the user has an account, show options
        //                if hasAccount {
                        // shop
                        Text("shop")
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphTwo()
                            .padding(.subHeadingFrontIndent)
                            .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                        BuyCoasterButton()
                        // account
                        Text("account")
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphTwo()
                            .padding(.subHeadingFrontIndent)
                            .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                        
                        ChangeDisplayNameButton()
                        if connectedToSpotify {
                            // option to disconnect
                            ManageSpotifyButton(connectedToSpotify: $connectedToSpotify)
                        }
                        else {
                            // link spotify
                            LinkSpotifySettingsButton()
                        }
                    
                        SignOutButton(hasAccount: $hasAccount, connectedToSpotify: $connectedToSpotify, hasConnectedCoasters: $hasConnectedCoasters)
                        // if the user has connected coasters, give option to limit reqs
        //                    if hasConnectedCoasters {
        //                        Text("coaster management")
        //                            .foregroundColor(Color.white)
        //                            .fonzParagraphTwo()
        //                            .padding(25)
        //                            .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
        //                        LimitSongRequestsButton()
        //                    }

        //                }
                    Spacer()
                }
                // if user needs to create an acc
                else {
                    CreateAccountPrompt(hasAccount: $hasAccount, showModal: $throwCreateAccountModal)
                }
            }
            
        }
        .background(
            ZStack{
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
                    .darkenView(!hasAccount)
                VStack{
                    Spacer()
                    Image("mountainProfile")
                        .opacity(0.4)
                        .frame(maxWidth: UIScreen.screenWidth)
                }
            }, alignment: .bottom)
        .ignoresSafeArea()
    }
}
