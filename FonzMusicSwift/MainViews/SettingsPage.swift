//
//  SettingsPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/14/21.
//

import SwiftUI

struct SettingsPage: View {
    
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // bool on if the user has coasters connected
    @Binding var hasConnectedCoasters : Bool
    // bool to launch create account modal
    @State var throwCreateAccountModal = false
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    Text("settings")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
//                        .padding(.bottom, 20)
                    Spacer()
                }
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
                // if the user has an account, show options
                if hasAccount {
                    ChangeDisplayNameButton()
                    ManageSpotifyButton()
                    SignOutButton()
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
                    CreateAccountButton(throwCreateAccountModal: $throwCreateAccountModal)
                        .sheet(isPresented: $throwCreateAccountModal) {
                            CreateAccountPrompt()
                        }
                }

                Spacer()
            }
        }
        .background(
            ZStack{
               
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
               
                Image("mountainProfile")
                    .opacity(0.4)
                    .frame(maxWidth: UIScreen.screenWidth)
            }, alignment: .bottom)
        .ignoresSafeArea()
    }
}
