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
    
    @Binding var hasConnectedCoasters : Bool
    
    @State var throwCreateAccountModal = false
    
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
                Text("shop")
                    .foregroundColor(Color.white)
                    .fonzParagraphTwo()
                    .padding(25)
                    .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                BuyCoasterButton()
                Text("account")
                    .foregroundColor(Color.white)
                    .fonzParagraphTwo()
                    .padding(25)
                    .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                if hasAccount {
                    ChangeDisplayNameButton()
                    ManageSpotifyButton()
                    SignOutButton()
                    if hasConnectedCoasters {
                        Text("coaster management")
                            .foregroundColor(Color.white)
                            .fonzParagraphTwo()
                            .padding(25)
                            .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                        LimitSongRequestsButton()
                    }

                }
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
