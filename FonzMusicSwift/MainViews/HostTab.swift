//
//  HostTab.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct HostTab: View {
    
// ---------------------------------- inherited from parent -------------------------------------------

    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToHost: CoastersFromApi

    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            if (!userAttributes.getConnectedToSpotify() || !userAttributes.getHasConnectedCoasters()) {
                HStack{
                    Text("host")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphOne()
                        .padding(.headingFrontIndent)
                        .padding(.top, .headingTopIndent)
                    Spacer()
                }
                
                HostSetup(userAttributes: userAttributes, coastersConnectedToHost: coastersConnectedToHost)
            }
            else {
                HStack{
                    Text("coasters")
                        .foregroundColor(.white)
                        .fonzParagraphOne()
                        .padding(.headingFrontIndent)
                        .padding(.top, .headingTopIndent)
                        .padding(.bottom, 20)
                    Spacer()
                }
                CoasterDashboardPage(userAttributes: userAttributes, coastersConnectedToHost: coastersConnectedToHost)
            }
            Spacer()
        }
        .background(
            ZStack{
                if (userAttributes.getConnectedToSpotify() && userAttributes.getHasConnectedCoasters()) {
                    Color.lilac
                }
                else {
                    Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
                }
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
