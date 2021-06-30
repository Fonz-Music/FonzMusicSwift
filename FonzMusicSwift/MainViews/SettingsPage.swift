//
//  SettingsPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/14/21.
//

import SwiftUI

struct SettingsPage: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    Text("settings")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    Spacer()
                }
                ChangeDisplayNameButton()
                BuyCoasterButton()
                ManageSpotifyButton()
                SignOutButton()
//                LimitSongRequestsButton()
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
