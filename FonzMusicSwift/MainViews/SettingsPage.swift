//
//  SettingsPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/14/21.
//

import SwiftUI
import KeychainAccess

struct SettingsPage: View {
    
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
                HStack{
                    Text("account")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
                        .addOpacity(!hasAccount)
//                        .padding(.bottom, 20)
                    Spacer()
                }
                // if the user has an account, show options
                if hasAccount {
                    // shop
                    Text("shop")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphTwo()
                        .padding(25)
                        .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                    BuyCoasterButton()
                    // account
                    Text("account")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphTwo()
                        .padding(25)
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
                   
                    SignOutButton(hasAccount: $hasAccount)
                    // if the user has connected coasters, give option to limit reqs
    //                    if hasConnectedCoasters {
    //                        Text("coaster management")
    //                            .foregroundColor(Color.white)
    //                            .fonzParagraphTwo()
    //                            .padding(25)
    //                            .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
    //                        LimitSongRequestsButton()
    //                    }

                }
                // otherwise, offer to create an account
                else {
                    VStack{
                        ScrollView{
                            CreateAccountView(hasAccount: $hasAccount, showModal: $throwCreateAccountModal)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                        }
//                        .frame(height: UIScreen.screenHeight * 0.8)
//                        .padding(.bottom, 30)
                    }
                    
                    .background(
                        RoundedRectangle(cornerRadius: .cornerRadiusBlocks)
                            .foregroundColor(colorScheme == .light ? Color.white: Color.darkBackground)
                            .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.7)
                        , alignment: .top
                            
                    )
                    .frame(width: UIScreen.screenWidth * 0.8)
//                    .padding(30)
                    

                }

                Spacer()
            }
            .onAppear {

//                let keychain = Keychain(service: "api.fonzmusic.com")
//                let email = UserDefaults.standard.string(forKey: "userEmail")
//                let password = keychain[email!]
//
//                print("password is \(password ?? "null")")



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
