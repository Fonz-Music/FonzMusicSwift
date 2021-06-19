//
//  HostSetup.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

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
            Image("spotifyIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .frame(width: 125, height: 125)
        })
        .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .successGreen))
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

