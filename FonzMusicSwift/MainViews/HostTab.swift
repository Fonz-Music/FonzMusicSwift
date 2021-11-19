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

    @State var launchShopModal : Bool = false
    
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            if (!userAttributes.getHasConnectedCoasters()) {
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
                    HStack{
                        Spacer()
                        Button {
                            launchShopModal = true
//                            guard let url = URL(string: "https://www.fonzmusic.com/buy") else {
//                                return
//                            }
//                            openURL(url)
                        } label: {
                            Image(systemName: "cart.badge.plus")
                                .resizable()
                                .frame(width: 22, height: 20, alignment: .center)
//                                .foregroundColor(.white)
                                .foregroundColor(colorScheme == .light ? Color.gray: Color.white)

                                .padding(10)

                        }
                        .buttonStyle(BasicFonzButtonCircleNoBorder(bgColor: colorScheme == .light ? Color.white: Color.darkBackground, secondaryColor: .lilac))
//                        .buttonStyle(BasicFonzButtonCircleNoBorder(bgColor: Color.white, secondaryColor: .amber))
                        .padding(.horizontal, .headingFrontIndent)
                    }
                    .padding(.top, .headingTopIndent * 0.5)
                    
                }
                CoasterDashboardPage(userAttributes: userAttributes, coastersConnectedToHost: coastersConnectedToHost)
            }
            Spacer()
        }
        .sheet(isPresented: $launchShopModal) {
            ShopPage(launchShopModal: $launchShopModal)
        }
        .background(
            ZStack{
                if (userAttributes.getHasConnectedCoasters()) {
                    Color.lilac
                }
                else {
                    Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
                }
                VStack{
                    Spacer()
                    Image("mountainProfile")
                        .opacity(0.6)
                        .frame(maxWidth: UIScreen.screenWidth)
                }
            }, alignment: .bottom)
        .ignoresSafeArea()
//        .onAppear {
//            userAttributes.determineIfUserHasConnectedCoasters()
//        }
    }
}
