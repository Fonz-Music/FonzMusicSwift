//
//  ChangeDisplayNameButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct ChangeDisplayNameButton: View {
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    @Environment(\.colorScheme) var colorScheme
    
    @State var isExpanded = false
    @State var newDisplayName: String = ""
    
    var body: some View {
        VStack{
            Button(action: {
                withAnimation{
                    isExpanded.toggle()
                }
                FirebaseAnalytics.Analytics.logEvent("userPressedChangeName", parameters: ["user":"user", "tab": "settings"])
            }, label: {
                HStack {
                    HStack(spacing: 5) {
                        Image("changeNameIcon").resizable().frame(width: 30 ,height: 27, alignment: .leading)
                        Text(userAttributes.getUserDisplayName())
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzButtonText()
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings, height: 20)
                .padding()
                
            })
            .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        }
        if isExpanded {
            VStack{
                Text("change your name")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                    .padding(5)
            HStack{
                TextField("name", text: $newDisplayName)
                    .foregroundColor(colorScheme == .light ? Color.darkButton : Color.white)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .fonzShadow()
                    .padding(10)
                    .multilineTextAlignment(.leading)
                    .fonzParagraphTwo()
                Button {
                    print("\(newDisplayName)")
                    
                   
                    withAnimation {
                        isExpanded = false
                    }
                    FirebaseAnalytics.Analytics.logEvent("hostRenamedCoaster", parameters: ["user":"host", "tab":"host"])
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .frame(width: 20 , height: 20, alignment: .center)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                    
    //                    .padding()
                }
                .frame(width: 80, height: 40, alignment: .center)
                .buttonStyle(BasicFonzButton(bgColor: .amber, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                .padding(.vertical, 5)
            }
            .frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings)
        }
        }
        
    }
}
