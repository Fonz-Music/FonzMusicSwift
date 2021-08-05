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

    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    @State var throwCreateAccountModal = false
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            VStack{
                if userAttributes.getHasAccount() {
                    HStack{
                        Text("account")
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                            .padding(.headingFrontIndent)
                            .padding(.top, .headingTopIndent)
                            .addOpacity(!userAttributes.getHasAccount())
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
                        
                        ChangeDisplayNameButton(userAttributes: userAttributes)
                    if userAttributes.getConnectedToSpotify() {
                            // option to disconnect
                            ManageSpotifyButton(userAttributes: userAttributes)
                        }
                        else {
                            // link spotify
                            LinkSpotifySettingsButton()
                        }
                    
//                        SignOutButton(hasAccount: $hasAccount, connectedToSpotify: $connectedToSpotify, hasConnectedCoasters: $hasConnectedCoasters)
                    SignOutButton(userAttributes: userAttributes)
                        // if the user has connected coasters, give option to limit reqs
        //                    if userAttributes.getHasConnectedCoasters() {
        //                        Text("coaster management")
        //                            .foregroundColor(Color.white)
        //                            .fonzParagraphTwo()
        //                            .padding(.headingFrontIndent)
        //                            .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
        //                        LimitSongRequestsButton()
        //                    }

        //                }
                    Spacer()
                }
                // if user needs to create an acc
                else {
                    CreateAccountPrompt(userAttributes: userAttributes, showModal: $throwCreateAccountModal)
                }
            }
            
        }
        .background(
            ZStack{
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
                    .darkenView(!userAttributes.getHasAccount())
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
